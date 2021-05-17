import * as express from 'express'
import { Logger } from '../common'
import { WorkoutsController } from '../controllers/workoutscontroller'

const app = express();
const log = new Logger();

app.get("/:username", (req, res) => {

    var username = req.params.username

    var sliced = username.slice(1);

    var paramList:string[];
    paramList = [sliced];

    WorkoutsController.getInstance().getWorkoutsOfACostumer("wk_consultWorkoutsPerClient", paramList)
    .then((data)=>{
        res.json(data);
    })
    .catch((err)=>{
        log.error(err);
        return "";
    });
});

export { app as workoutsrouter };