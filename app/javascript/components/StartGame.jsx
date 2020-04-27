import React from "react";
import Matrix from "./Matrix";
import {Button, ButtonGroup, Container, Form, Row} from "react-bootstrap";
import Col from "react-bootstrap/Col";
import config from '../config'
import Spinner from "react-bootstrap/Spinner";
import FormControl from "react-bootstrap/FormControl";
import {resetTimer, initializeTimer} from "../Timer";

class StartGame extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            matrixList: [],
            gameStarted: false,
            doAfterTimeoutDone: true,
            guessWord: "",
            guessWordList: [],
            countdown: "0 : 0",
            finalScore:0,
            finalScoreReturned:false,
            submitted:false,
            message:"",
            validWords:[],
            matrixClassNames:"disable",
            callingFinalScore:false
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
        this.setState({gameStarted : true, doAfterTimeoutDone:true});
        this.initTimer();
    };

    resetMatrix = (props) =>{
        this.setState({guessWord:'', matrixList:[], gameStarted: false, countdown:"0 : 0", finalScore:0, validWords:[], guessWordList:[]});
            resetTimer();
        this.fetchMatrixData()
    };

    onChange(event) {
        this.setState({ [event.target.name]: event.target.value });
    }

    initTimer = () => {
        // Update the count every 1 second
        const timeOutLimit = config.timeOutLimit;
        const self = this;
        const updateTimerCallback = (counterTime) => {

            self.setState({countdown : counterTime});
        }
        const whenDoneCallback = () => {
                self.setState({countdown: "0 : 0", gameStarted: false});
                if (self.state.doAfterTimeoutDone) {
                    self.getFinalScore();
                    self.setState({doAfterTimeoutDone: false, callingFinalScore: true});
                }
        }

        initializeTimer(timeOutLimit, updateTimerCallback, whenDoneCallback);
    }

    onSubmit(event) {
        event.preventDefault();
        const guessWord = this.state.guessWord;

        if (guessWord.length === 0)
            return;

        let oldWords = this.state.guessWordList;
        oldWords.push(guessWord);

        this.setState({guessWordList:oldWords, guessWord:'', submitted:true});
/*
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
*/
    }

    getFinalScore = () => {
        const baseApi = config.baseApi;
        const url = baseApi + "/boggle/getScore";
        let self = this;
        this.callApi(url, "POST", {'words':this.state.guessWordList})
            .then(response => {
                if (response.ok) {
                    return response.json();
                }
                throw new Error("Network response was not ok.");
            })
            .then(data => { console.log(data); self.setState({finalScore:data.score, finalScoreReturned:true, callingFinalScore:false, validWords:data.validWords}) });

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

                        <h4 className="text-error">
                            Click Start to start the counter
                        </h4>

                        <Row>
                            <Col>
                                <Button type="button" variant="outline-warning" onClick={this.startGame} block>
                                    Start Game
                                </Button>
                            </Col>
                        </Row>
                        <br/>
                        <Row className={this.state.matrixClassNames}>
                            <Col>
                                <Row className="align-center">
                                    <Col>
                                        <Button type="button" variant="secondary" onClick={this.resetMatrix}>
                                            Reset Matrix
                                        </Button>
                                    </Col>
                                    <Col>
                                        <span className="display-4">{this.state.countdown}</span>
                                    </Col>
                                </Row>
                                <Row>
                                    <Col><br/></Col>
                                </Row>
                                <Row>
                                    <Col>
                                        <Matrix matrixData={this.state.matrixList}/>
                                    </Col>
                                </Row>
                            </Col>
                        </Row>
                        <Row>

                            <Col>
                            <Form onSubmit={this.onSubmit}>

                                <div className="form-group">
                                    <label htmlFor="recipeIngredients">Input a word:</label>
                                    <FormControl
                                        type="text"
                                        name="guessWord"
                                        id="guessWord"
                                        className="form-control"
                                        required
                                        disabled={!this.state.gameStarted}
                                        onChange={this.onChange}
                                        value={this.state.guessWord}
                                    />
                                    <small id="guessWordHelp" className="form-text text-muted">
                                        Enter single word at a time
                                    </small>
                                </div>
                                <Button type="submit" variant="outline-warning" disabled={!this.state.gameStarted} block>
                                    {(!this.state.finalScoreReturned && this.state.callingFinalScore)?'Loading ...':'Validate'}
                                </Button>
                            </Form>
                            </Col>
                        </Row>
                    </Col>
                    <Col className="right-section">
                        <legend> Your Final Score is:</legend>
                        {(!this.state.finalScoreReturned && this.state.callingFinalScore)?
                            <Loader />: <ScoreComp finalScore={this.state.finalScore} validWords={this.state.validWords} totalWords={this.state.guessWordList}/>
                        }
                    </Col>
                </Row>
            </Container>
        );
    }

}

const ScoreComp = (props) => (

    <Row className="justify-center">
        <Col>
            <Row>
                <Col>
                    <h4 className="display-3">{props.finalScore}</h4>
                </Col>
            </Row>
            <Row>
                <Col>
                    <Row>
                        <Col>
                            <legend>Valid Words</legend>
                            <ul className="list-group">
                                {props.validWords.map((item, i) => (
                                    <li className="list-group-item" key={i}>
                                        <span className="small text-success"> {item} </span>
                                    </li>
                                ))}

                            </ul>
                        </Col>
                        <Col>
                            <legend>All Words</legend>
                            <ul className="list-group">
                                {props.totalWords.map((item, i) => (
                                    <li className="list-group-item" key={i}>
                                        <span className="small text-warning"> {item} </span>
                                    </li>
                                ))}

                            </ul>

                        </Col>
                    </Row>
                </Col>
            </Row>

        </Col>
    </Row>
);

const Loader = () => (

    <Spinner animation="border" role="status">
        <span className="sr-only">Loading...</span>
    </Spinner>
);
export default StartGame;