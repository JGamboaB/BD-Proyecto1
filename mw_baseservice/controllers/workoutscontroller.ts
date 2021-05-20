import { MySQLRepo } from '../repositories/mysqlrepository'
import { Logger } from '../common'

export class WorkoutsController
{
    private static instance: WorkoutsController;
    private log: Logger;

    private constructor()
    {
        this.log = new Logger();
        try
        {
        } catch (e)
        {
            this.log.error(e);
        }
    }

    public static getInstance() : WorkoutsController
    {
        if (!this.instance)
        {
            this.instance = new WorkoutsController();
        }
        return this.instance;
    }

    public getWorkoutsOfACostumer(pStoredProcedure: string, pParamList: Array<any>) : Promise<Response>
    {
        const sqlrepo = new MySQLRepo();
        return sqlrepo.callStoredProcedure(pStoredProcedure, pParamList);
    }

    public getWorkout(pStoredProcedure: string, pParamList: Array<any>) : Promise<Response>
    {
        const sqlrepo = new MySQLRepo();
        return sqlrepo.callStoredProcedure(pStoredProcedure, pParamList);
    }
}