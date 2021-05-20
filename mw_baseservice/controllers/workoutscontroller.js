"use strict";
exports.__esModule = true;
exports.WorkoutsController = void 0;
var mysqlrepository_1 = require("../repositories/mysqlrepository");
var common_1 = require("../common");
var WorkoutsController = /** @class */ (function () {
    function WorkoutsController() {
        this.log = new common_1.Logger();
        try {
        }
        catch (e) {
            this.log.error(e);
        }
    }
    WorkoutsController.getInstance = function () {
        if (!this.instance) {
            this.instance = new WorkoutsController();
        }
        return this.instance;
    };
    WorkoutsController.prototype.getWorkoutsOfACostumer = function (pStoredProcedure, pParamList) {
        var sqlrepo = new mysqlrepository_1.MySQLRepo();
        return sqlrepo.callStoredProcedure(pStoredProcedure, pParamList);
    };
    WorkoutsController.prototype.getWorkout = function (pStoredProcedure, pParamList) {
        var sqlrepo = new mysqlrepository_1.MySQLRepo();
        return sqlrepo.callStoredProcedure(pStoredProcedure, pParamList);
    };
    return WorkoutsController;
}());
exports.WorkoutsController = WorkoutsController;
