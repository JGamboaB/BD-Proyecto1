"use strict";
exports.__esModule = true;
var express = require("express");
var common_1 = require("../common");
var chatsrouter_1 = require("./chatsrouter");
var Routes = /** @class */ (function () {
    function Routes() {
        this.express = express();
        this.logger = new common_1.Logger();
        this.middleware();
        this.routes();
    }
    Routes.prototype.middleware = function () {
        this.express.use(express.json());
        this.express.use(express.urlencoded({ extended: false }));
    };
    Routes.prototype.routes = function () {
        this.express.use('/chats', chatsrouter_1.chatsrouter);
        this.logger.info("Se ha usado esta ruta");
    };
    return Routes;
}());
exports["default"] = new Routes().express;
