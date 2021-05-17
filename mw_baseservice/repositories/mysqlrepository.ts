import { response } from 'express'
import { createPool } from 'mysql2'
import * as mysql2 from 'mysql2/promise'
import { Logger } from '../common'

export class MySQLRepo {
    private log: Logger
    private mysql: any
    private connection: any

    constructor()
    {
        this.connect()
    }

    public connect()
    {
        this.mysql = require('mysql2');

        this.connection = this.mysql.createConnection({
            host: 'localhost',
            user: 'root',
            password: '123456',
            database: 'MyWorkouts'
          });
    }

    public callStoredProcedure(pStoredProcedure: string, pParamList: Array<any>) : Promise<Response>
    {
        const result = this.connection.promise().query("CALL " + pStoredProcedure + "(?)", pParamList)
        return result;
    }
}




