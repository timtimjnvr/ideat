import { Router, Request, Response } from "express";

import Recipes from "./controllers/recipes";

const routes: Router = Router();

routes.get("/",(req: Request, res: Response)=>{
    res.status(200).end();}
);

routes.get("/recipes", Recipes.getRecipesHandler);

export default routes;