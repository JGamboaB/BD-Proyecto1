import * as express from 'express';
import { Logger } from '../common';
import { chatsrouter } from './chatsrouter';

class Routes {

    public express: express.Application;
    public logger: Logger;

    constructor() {
        this.express = express();
        this.logger = new Logger();
        this.middleware();
        this.routes();
    }

    private middleware(): void {
        this.express.use(express.json());
        this.express.use(express.urlencoded({ extended: false }));
    }

    private routes(): void {
        this.express.use('/chats', chatsrouter);
        this.logger.info("Se ha usado esta ruta");
    }
}

export default new Routes().express;