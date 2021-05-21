import { MySQLRepo } from '../repositories/mysqlrepository'
import { Logger } from '../common'

export class PaymentsController
{
    private static instance: PaymentsController;
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

    public static getInstance() : PaymentsController
    {
        if (!this.instance)
        {
            this.instance = new PaymentsController();
        }
        return this.instance;
    }

    public registerPayment(pStoredProcedure: string, pParamList: Array<any>) : Promise<Response>
    {
        const sqlrepo = new MySQLRepo();
        return sqlrepo.callRegisterPayment(pParamList);
    }
}