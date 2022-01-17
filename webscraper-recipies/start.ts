const app = require("./server");
const port: any = 8888;

app.listen(port, ()=>{ 
    console.log("Server listening on " + port);
});
