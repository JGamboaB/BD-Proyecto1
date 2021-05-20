"use strict";
exports.__esModule = true;
exports.workoutsrouter = void 0;
var express = require("express");
var common_1 = require("../common");
var workoutscontroller_1 = require("../controllers/workoutscontroller");
var app = express();
exports.workoutsrouter = app;
var log = new common_1.Logger();
app.get("/list/:username", function (req, res) {
    var username = req.params.username;
    var sliced = username.slice(1);
    var paramList;
    paramList = [sliced];
    workoutscontroller_1.WorkoutsController.getInstance().getWorkoutsOfACostumer("wk_consultWorkoutsPerClient", paramList)
        .then(function (data) {
        res.json(data);
    })["catch"](function (err) {
        log.error(err);
        return "";
    });
});
app.get("/workout/:id", function (req, res) {
    var id = req.params.id;
    var idWorkout = +(id.slice(1));
    console.log(idWorkout);
    var paramList = [idWorkout];
    workoutscontroller_1.WorkoutsController.getInstance().getWorkout("wk_consultWorkout", paramList)
        .then(function (data) {
        res.json(data);
    })["catch"](function (err) {
        log.error(err);
        return "";
    });
});
