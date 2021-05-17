"use strict";
exports.__esModule = true;
exports.chatsrouter = void 0;
var express = require("express");
var common_1 = require("../common");
var chatscontroller_1 = require("../controllers/chatscontroller");
var app = express();
exports.chatsrouter = app;
var log = new common_1.Logger();
app.get("/:username", function (req, res) {
    var username = req.params.username;
    chatscontroller_1.ChatsController.getInstance().getChatsOfACostumer(username)
        .then(function (data) {
        res.json(data);
    })["catch"](function (err) {
        log.error(err);
        return "";
    });
});
