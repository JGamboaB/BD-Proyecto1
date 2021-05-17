"use strict";
exports.__esModule = true;
exports.TrackingController = void 0;
var mysqlrepository_1 = require("../repositories/mysqlrepository");
var common_1 = require("../common");
var TrackingController = /** @class */ (function () {
    function TrackingController() {
        this.log = new common_1.Logger();
        try {
        }
        catch (e) {
            this.log.error(e);
        }
    }
    TrackingController.getInstance = function () {
        if (!this.instance) {
            this.instance = new TrackingController();
        }
        return this.instance;
    };
    TrackingController.prototype.getTrackingOfACostumer = function (pStoredProcedure, pParamList) {
        var sqlrepo = new mysqlrepository_1.MySQLRepo();
        return sqlrepo.callStoredProcedure(pStoredProcedure, pParamList);
    };
    return TrackingController;
}());
exports.TrackingController = TrackingController;
