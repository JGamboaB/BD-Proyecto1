"use strict";
exports.__esModule = true;
exports.MySQLRepo = void 0;
var MySQLRepo = /** @class */ (function () {
    function MySQLRepo() {
        this.connect();
    }
    MySQLRepo.prototype.connect = function () {
        this.mysql = require('mysql2');
        this.connection = this.mysql.createConnection({
            host: 'localhost',
            user: 'root',
            password: '123456',
            database: 'MyWorkouts'
        });
    };
    MySQLRepo.prototype.callStoredProcedure = function (pStoredProcedure, pParamList) {
        var result = this.connection.promise().query("CALL " + pStoredProcedure + "(?)", pParamList);
        return result;
    };
    return MySQLRepo;
}());
exports.MySQLRepo = MySQLRepo;
