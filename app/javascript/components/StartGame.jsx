import React from "react";
import Matrix from "./Matrix";
import {Button, ButtonGroup, Container, Form, Row} from "react-bootstrap";
import Col from "react-bootstrap/Col";
import config from '../config'

class StartGame extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            matrixList: [],
            gameStarted: true,
            guessWord: "",
            countdown: 0,
            timerTime: config.timerLimit,
            finalScore:0,
            message:"",
            validWords:[],
            timer:null
        };

        this.onChange = this.onChange.bind(this);
        this.onSubmit = this.onSubmit.bind(this);
    }

    componentDidMount() {
        this.fetchMatrixData()
    }

    fetchMatrixData(){

        let url = config.baseApi + "/boggle/getMatrix";
        const self = this;
        fetch(url, {
            method: "GET",
            headers: {
                "Content-Type": "application/json"
            }
        })
            .then(response => {
                if (response.ok) {
                    return response.json();
                }
                throw new Error("Network response was not ok.");
            }).then(data =>{
                console.log(data);
                self.setState({matrixList:data});
            })
            .catch(error => console.log(error.message));
    }

    startGame = () => {
        this.setState({gameStarted : false});
        this.initTimer();
    };

    resetMatrix = (e) =>{
        this.setState({guessWord:'', matrixList:[], gameStarted: true, countdown:0, timerTime:config.timerLimit});
        clearInterval(this.state.timer);
        this.fetchMatrixData()
    };

    onChange(event) {
        this.setState({ [event.target.name]: event.target.value });
    }

    initTimer = () => {
        const timerStep = 1000; //declines by 1 seconds
        const futureTime = this.state.timerTime;
        let doAfterTimeoutDone = true;
        // Update the count every 1 second
        const self = this;
        this.state.timer = setInterval(function() {

            let nowTime = new Date().getTime();
            let difference = futureTime - nowTime;

            // Calculating minutes and seconds
            let minutes = Math.floor((difference % (1000 * 60 * 60)) / (1000 * 60));
            let seconds = Math.floor((difference % (1000 * 60)) / 1000);

            // Output the result in an element with id="demo"
            let counterTime = minutes + "m " + seconds + "s ";

            self.setState({countdown:counterTime});

            // doWhen timer limit is reached
            if (difference < 0) {
                clearInterval(self.state.timer);
                if(doAfterTimeoutDone){
                    self.setState({countdown:0, gameStarted: true});
                    self.getFinalScore();
                    doAfterTimeoutDone = false;
                }
            }
        }, timerStep);
    }

    onSubmit(event) {
        event.preventDefault();
        const guessWord = this.state.guessWord;

        this.setState({guessWord:''});
        if (guessWord.length === 0)
            return;

        const url = config.baseApi + "/boggle/saveWord";
        const body = {
            word:guessWord,
        };
        this.callApi(url, 'POST', body)
            .then(response => {
                if (response.ok) {
                    return response.json();
                }
                throw new Error("Network response was not ok.");
            })
            .then(data => {
                console.log(response);
                this.setState({message: data ? "Your word is validated" : "You word is invalidate. You wont gain score for this word"})
            })
            .catch(error => console.log(error.message));
    }

    getFinalScore = () => {
        const baseApi = config.baseApi;
        const url = baseApi + "/boggle/getScore";
        let self = this;
        this.callApi(url)
            .then(response => {
                if (response.ok) {
                    return response.json();
                }
                throw new Error("Network response was not ok.");
            })
            .then(data => { console.log(data); self.setState({finalScore:data.score, validWords:data.validWords}) });

    };

    callApi(url, method="POST", body=""){
        let params = body?JSON.stringify(body):"";
        return fetch(url, {
            method: method,
            headers: {
                "Content-Type": "application/json"
            },
            body: params
        })
    }

    render() {
        return (
            <Container>
                <Row>
                    <Col className="left-side">
                        <h1 className="font-weight-normal mb-5">
                            A Boggle Game
                        </h1>
                        <Row className="matrix">
                            <Col>
                                <Row>
                                    <Col>
                                        <ButtonGroup>

                                        <Button type="button" variant="outline-warning" onClick={this.startGame}>
                                            Start Game
                                        </Button>
                                        <Button type="button" variant="secondary" onClick={this.resetMatrix}>
                                            Reset Matrix
                                        </Button>
                                        </ButtonGroup>
                                    </Col>
                                    <Col>
                                        <span className="display-4">{this.state.countdown}</span>
                                    </Col>
                                </Row>
                                <Row></Row>
                                <Row>
                                    <Col>
                                        <Matrix matrixData={this.state.matrixList}/>
                                    </Col>
                                </Row>
                            </Col>
                        </Row>
                        <Row>

                            <Form onSubmit={this.onSubmit}>

                                <div className="form-group">
                                    <label htmlFor="recipeIngredients">Input a word:</label>
                                    <input
                                        type="text"
                                        name="guessWord"
                                        id="guessWord"
                                        className="form-control"
                                        required
                                        disabled={this.state.gameStarted}
                                        onChange={this.onChange}
                                    />
                                    <small id="guessWordHelp" className="form-text text-muted">
                                        Enter single word at a time
                                    </small>
                                </div>
                                <Button type="submit" variant="outline-warning" disabled={this.state.gameStarted}>
                                    Validate
                                </Button>
                            </Form>
                        </Row>
                    </Col>
                    <Col className="right-section">
                        <Row>
                           <Col>
                               <legend> Your Final Score is:</legend>
                               <h4 className="display-3">{this.state.finalScore}</h4>
                           </Col>
                        </Row>
                        <Row>
                            <Col>
                                <Row>
                                    <ul>
                                        {this.state.validWords.map((item, i) => (
                                                <li key={i}>
                                                    <span className="small"> {item} </span>
                                                </li>
                                        ))}

                                    </ul>
                                </Row>
                            </Col>
                        </Row>
                    </Col>
                </Row>
            </Container>
        );
    }

}

export default StartGame;