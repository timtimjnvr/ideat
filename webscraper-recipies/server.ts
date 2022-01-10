const express = require ("express");
import routes from "./routes";

const port: any = 8888;
const app: any = express();

app.use(express.json());
app.use("/",routes);
app.listen(port);
console.log("Server listening on "+ port);