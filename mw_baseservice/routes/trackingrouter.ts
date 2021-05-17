import * as express from 'express'
import { Logger } from '../common'
import { TrackingController } from '../controllers/trackingcontroller'

const app = express();
const log = new Logger();

app.get("/:username", (req, res) => {

    var username = req.params.username

    var sliced = username.slice(1);

    var paramList:string[];
    paramList = [sliced];

    TrackingController.getInstance().getTrackingOfACostumer("wk_consultTrackings", paramList)
    .then((data)=>{
        res.json(data);
    })
    .catch((err)=>{
        log.error(err);
        return "";
    });

});

export { app as trackingrouter };