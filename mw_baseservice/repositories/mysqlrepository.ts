import { response } from 'express'
import { createPool } from 'mysql2'
import * as mysql2 from 'mysql2/promise'
import { Logger } from '../common'

export class MySQLRepo {
    private log: Logger

    constructor()
    {
    }

    public async callStoredProcedure(pStoredProcedure: string, pParamList: Array<any>) : Promise<Response>
    {
        const mysql = require('mysql2/promise');

        const connection = await mysql.createConnection({
            host: '172.17.0.2',
            user: 'root',
            password: '123456',
            database: 'MyWorkouts'
          });

        const result = await connection.query("CALL " + pStoredProcedure + "(?)", pParamList)

        return result[0][0];
    }
}




