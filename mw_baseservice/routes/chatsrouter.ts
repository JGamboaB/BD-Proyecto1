import * as express from 'express'
import { stringify } from 'querystring';
import { Logger } from '../common'
import { ChatsController } from '../controllers/chatscontroller'

const app = express();
const log = new Logger();


app.get("/:username", (req, res) => {

    var username = req.params.username

    var sliced = username.slice(1);

    var paramList:string[];
    paramList = [sliced];

    ChatsController.getInstance().getChatsOfACostumer("wk_consultChats", paramList)
    .then((data)=>{
        res.json(data);
    })
    .catch((err)=>{
        log.error(err);
        return "";
    });

});

export { app as chatsrouter };