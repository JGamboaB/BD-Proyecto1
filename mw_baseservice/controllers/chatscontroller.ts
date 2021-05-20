import { MySQLRepo } from '../repositories/mysqlrepository'
import { Logger } from '../common'

export class ChatsController
{
    private static instance: ChatsController;
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

    public static getInstance() : ChatsController
    {
        if (!this.instance)
        {
            this.instance = new ChatsController();
        }
        return this.instance;
    }

    public getChatsOfACostumer(pStoredProcedure: string, pParamList: Array<any>) : Promise<Response>
    {
        const sqlrepo = new MySQLRepo();
        return sqlrepo.callStoredProcedure(pStoredProcedure, pParamList);
    }

    public getChat(pStoredProcedure: string, pParamList: Array<any>) : Promise<Response>
    {
        const sqlrepo = new MySQLRepo();
        return sqlrepo.callStoredProcedure(pStoredProcedure, pParamList);
    }
}