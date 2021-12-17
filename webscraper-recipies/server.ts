import express from "express";
import routes from "./routes";

const port: any = 8888;
const app: express.Application = express();

app.use("/",routes);
app.listen(port);
console.log("Server listening on "+ port);