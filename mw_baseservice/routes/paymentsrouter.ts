import * as express from 'express'
import { Logger } from '../common'
import { PaymentsController } from '../controllers/paymentscontroller'

const app = express();
const log = new Logger();

app.post("/register",  (req, res) => {

    const amount: number = +(req.body.amount);

    console.log(req.body.clientusername)
    console.log(req.body.merchantname)
    console.log(amount)

    const paramList: (string|number)[] = [req.body.clientusername, req.body.merchantname, amount];

    PaymentsController.getInstance().registerPayment("wk_registerPayment", paramList)
    .then((data)=>{
        res.json(data);
    })
    .catch((err)=>{
        log.error(err);
        return "";
    });

});


export { app as paymentsrouter };