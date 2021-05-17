import * as express from 'express'
import { Logger } from '../common'
import { ChatsController } from '../controllers/chatscontroller'

const app = express();
const log = new Logger();

app.get("/:username", (req, res) => {

    var username = req.params.username

    ChatsController.getInstance().getChatsOfACostumer(username)
    .then((data)=>{
        res.json(data);
    })
    .catch((err)=>{
        log.error(err);
        return "";
    });

});

export { app as chatsrouter };