import * as express from 'express'
import { stringify } from 'querystring';
import { Logger } from '../common'
import { WorkoutsController } from '../controllers/workoutscontroller'

const app = express();
const log = new Logger();


app.get("/list/:username", (req, res) => {

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

app.get("/workout/:id", (req, res) => {

    var id = req.params.id

    var idWorkout: number = +(id.slice(1));

    console.log(idWorkout);

    var paramList: number[] = [idWorkout];

    WorkoutsController.getInstance().getWorkout("wk_consultWorkout", paramList)
    .then((data)=>{
        res.json(data);
    })
    .catch((err)=>{
        log.error(err);
        return "";
    });

});


export { app as workoutsrouter };