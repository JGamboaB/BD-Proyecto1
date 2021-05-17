"use strict";
exports.__esModule = true;
exports.TicketsController = void 0;
var mysqlrepository_1 = require("../repositories/mysqlrepository");
var common_1 = require("../common");
var TicketsController = /** @class */ (function () {
    function TicketsController() {
        this.log = new common_1.Logger();
        try {
        }
        catch (e) {
            this.log.error(e);
        }
    }
    TicketsController.getInstance = function () {
        if (!this.instance) {
            this.instance = new TicketsController();
        }
        return this.instance;
    };
    TicketsController.prototype.getTicketsOfAEmployee = function (pStoredProcedure, pParamList) {
        var sqlrepo = new mysqlrepository_1.MySQLRepo();
        return sqlrepo.callStoredProcedure(pStoredProcedure, pParamList);
    };
    return TicketsController;
}());
exports.TicketsController = TicketsController;
