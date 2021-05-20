"use strict";
exports.__esModule = true;
exports.ChatsController = void 0;
var mysqlrepository_1 = require("../repositories/mysqlrepository");
var common_1 = require("../common");
var ChatsController = /** @class */ (function () {
    function ChatsController() {
        this.log = new common_1.Logger();
        try {
        }
        catch (e) {
            this.log.error(e);
        }
    }
    ChatsController.getInstance = function () {
        if (!this.instance) {
            this.instance = new ChatsController();
        }
        return this.instance;
    };
    ChatsController.prototype.getChatsOfACostumer = function (pStoredProcedure, pParamList) {
        var sqlrepo = new mysqlrepository_1.MySQLRepo();
        return sqlrepo.callStoredProcedure(pStoredProcedure, pParamList);
    };
    ChatsController.prototype.getChat = function (pStoredProcedure, pParamList) {
        var sqlrepo = new mysqlrepository_1.MySQLRepo();
        return sqlrepo.callStoredProcedure(pStoredProcedure, pParamList);
    };
    return ChatsController;
}());
exports.ChatsController = ChatsController;
