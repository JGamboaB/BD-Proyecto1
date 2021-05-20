import * as express from 'express';
import Routes from './routes/routes';

class App {

public express: express.Application;
// private saludos:string[];

constructor() {
    this.express = express();
    this.middleware();
    this.routes();
}

private middleware(): void {
    this.express.use(express.json());
    this.express.use(express.urlencoded({ extended: false }));
}

private routes(): void {
    this.express.use('/api', Routes);
    this.express.use('*', (req, res) => {
        console.log(req.originalUrl);
        res.send("Request inválido");
        });
    }
}

export default new App().express;