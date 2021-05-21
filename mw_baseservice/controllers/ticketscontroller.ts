import { MySQLRepo } from '../repositories/mysqlrepository'
import { Logger } from '../common'

export class TicketsController
{
    private static instance: TicketsController;
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

    public static getInstance() : TicketsController
    {
        if (!this.instance)
        {
            this.instance = new TicketsController();
        }
        return this.instance;
    }

    public getTicketsOfAEmployee(pStoredProcedure: string, pParamList: Array<any>) : Promise<Response>
    {
        const sqlrepo = new MySQLRepo();
        return sqlrepo.callStoredProcedure(pStoredProcedure, pParamList);
    }

    public changeTicketStatus(pStoredProcedure: string, pParamList: Array<any>) : Promise<Response>
    {
        const sqlrepo = new MySQLRepo();
        return sqlrepo.callRegisterPayment(pParamList);
    }
}