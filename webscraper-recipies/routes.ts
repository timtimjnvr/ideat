import { Router, Request, Response } from "express";

import Recipes from "./controllers/recipes";

const routes: Router = Router();

routes.get("/recipes", Recipes.getRecipesHandler);

export default routes;