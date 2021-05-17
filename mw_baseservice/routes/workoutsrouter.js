"use strict";
exports.__esModule = true;
exports.workoutsrouter = void 0;
var express = require("express");
var common_1 = require("../common");
var workoutscontroller_1 = require("../controllers/workoutscontroller");
var app = express();
exports.workoutsrouter = app;
var log = new common_1.Logger();
app.get("/:username", function (req, res) {
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
