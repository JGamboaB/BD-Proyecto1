"use strict";
exports.__esModule = true;
exports.ticketsrouter = void 0;
var express = require("express");
var common_1 = require("../common");
var ticketscontroller_1 = require("../controllers/ticketscontroller");
var app = express();
exports.ticketsrouter = app;
var log = new common_1.Logger();
app.get("/:username", function (req, res) {
    var username = req.params.username;
    var sliced = username.slice(1);
    var paramList;
    paramList = [sliced];
    ticketscontroller_1.TicketsController.getInstance().getTicketsOfAEmployee("wk_consultTickets", paramList)
        .then(function (data) {
        res.json(data);
    })["catch"](function (err) {
        log.error(err);
        return "";
    });
});
