"use strict";
exports.__esModule = true;
exports.trackingrouter = void 0;
var express = require("express");
var common_1 = require("../common");
var trackingcontroller_1 = require("../controllers/trackingcontroller");
var app = express();
exports.trackingrouter = app;
var log = new common_1.Logger();
app.get("/:username", function (req, res) {
    var username = req.params.username;
    var sliced = username.slice(1);
    var paramList;
    paramList = [sliced];
    trackingcontroller_1.TrackingController.getInstance().getTrackingOfACostumer("wk_consultTrackings", paramList)
        .then(function (data) {
        res.json(data);
    })["catch"](function (err) {
        log.error(err);
        return "";
    });
});
