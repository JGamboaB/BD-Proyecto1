import { MySQLRepo } from '../repositories/mysqlrepository'
import { Logger } from '../common'

export class TrackingController
{
    private static instance: TrackingController;
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

    public static getInstance() : TrackingController
    {
        if (!this.instance)
        {
            this.instance = new TrackingController();
        }
        return this.instance;
    }

    public getTrackingOfACostumer(pStoredProcedure: string, pParamList: Array<any>) : Promise<Response>
    {
        const sqlrepo = new MySQLRepo();
        return sqlrepo.callStoredProcedure(pStoredProcedure, pParamList);
    }
}