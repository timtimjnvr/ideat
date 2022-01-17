const express = require ("express");
import routes from "./routes";

const app: any = express();

app.use(express.json());
app.use("/",routes);

module.exports = app;