"use strict";
exports.__esModule = true;
var express = require("express");
var routes_1 = require("./routes/routes");
var App = /** @class */ (function () {
    // private saludos:string[];
    function App() {
        this.express = express();
        this.middleware();
        this.routes();
    }
    App.prototype.middleware = function () {
        this.express.use(express.json());
        this.express.use(express.urlencoded({ extended: false }));
    };
    App.prototype.routes = function () {
        this.express.use('/api', routes_1["default"]);
        this.express.use('*', function (req, res) {
            res.send("Request inválido");
        });
    };
    return App;
}());
exports["default"] = new App().express;
