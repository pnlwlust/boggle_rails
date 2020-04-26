import React from "react";
import {BrowserRouter, Link, Route, Switch} from "react-router-dom";
import StartGame from "./StartGame";
import {Container, Row, Col} from "react-bootstrap";

export default () => (
    <Container>
        <Row>
            <Col>

            <h1 className="display-4">Boggle Game</h1>
            <small>
                Search for words that can be constructed from the letters of sequentially adjacent cubes,
                where "adjacent" cubes are those horizontally, vertically, and diagonally neighboring.
                Words must be at least three letters long, may include singular and plural (or other derived forms) separately,
                but may not use the same letter cube more than once per word. Enter each word and click on validate.
                After three minutes have elapsed, timer will stop and you will get you final result.
            </small>
            <hr className="my-4 border-warning" />
            <BrowserRouter>
                <Link
                    to="/start"
                    className="btn outline-warning"
                    role="button"
                >
                    Start Game
                </Link>
                <Switch>
                    <Route path="/start">
                        <StartGame />
                    </Route>
                </Switch>
            </BrowserRouter>
            </Col>
        </Row>
    </Container>
);