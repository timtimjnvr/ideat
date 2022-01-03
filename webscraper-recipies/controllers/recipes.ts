import {Request, Response } from "express";
import getRecipes from "../getRecipes";

class Recipes {

    static async getRecipesHandler(req: Request, res: Response): Promise<void>{
        const recipes = await getRecipes();
        //console.log(recipes);
        res.status(200).send({recipes}).end();
    }

}

export default Recipes;