import React from "react";
import { BrowserRouter as Router, Route, Switch } from "react-router-dom";
import Home from "../components/Home";
import StartGame from "../components/StartGame";

export default (
    <Router>
        <Switch>
            <Route path="/" exact component={Home} />
            <Route path="/start" exact component={StartGame} />

        </Switch>
    </Router>
);