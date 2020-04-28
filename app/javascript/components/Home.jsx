import React from "react";
import {BrowserRouter, Link, Route, Switch} from "react-router-dom";
import StartGame from "./StartGame";
import {Button, Container, Row, Col, Accordion, Table} from "react-bootstrap";

export default () => (
    <Container>
        <Row>
            <Col>
                <h1 className="display-4">Boggle Game</h1>
                <Accordion>
                    <Accordion.Toggle as={Button} variant="link" eventKey="0">
                        Click For Rules
                    </Accordion.Toggle>
                    <Accordion.Collapse eventKey="0">
                        <Row>
                            <Col>
                                <small>
                                    Search for words that can be constructed from the letters of sequentially adjacent cubes,
                                    where "adjacent" cubes are those horizontally, vertically, and diagonally neighboring.
                                    Words must be at least three letters long, may include singular and plural (or other derived forms) separately,
                                    but may not use the same letter cube more than once per word. Enter each word and click on validate.
                                    After three minutes have elapsed, timer will stop and you will get your final result.
                                </small>
                            </Col>
                            <Col>
                                    <small> Score Table</small>

                                    <Table bordered hover>
                                        <thead><tr><th> Length of Word </th><th> Points</th></tr></thead>
                                        <tbody>
                                        <tr><td> &lt;3 </td><td> 0</td></tr>
                                        <tr><td> 3, 4 </td><td> 1</td></tr>
                                        <tr><td> 5 </td><td> 2</td></tr>
                                        <tr><td> 6 </td><td> 3</td></tr>
                                        <tr><td> 7 </td><td> 5</td></tr>
                                        <tr><td> 8+ </td><td> 11</td></tr>
                                        </tbody>
                                    </Table>
                            </Col>
                        </Row>
                    </Accordion.Collapse>
                </Accordion>
                <hr className="border-warning" />
                <BrowserRouter>
                    <Link
                        to="/start"
                        className="outline-warning"
                        role="button"
                    >
                        Go to Game
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