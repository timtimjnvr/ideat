import {Request, Response } from "express";
import getRecipes from "../src/getRecipes";
import recipesConverter from "../src/recipesConverter";

class Recipes {

    static async getRecipesHandler(req: Request, res: Response): Promise<void>{
        const marmitionRecipes = await getRecipes(100);
        const recipes = await recipesConverter(marmitionRecipes)
        //console.log(recipes);
        res.status(200).send({recipes}).end();
    }

}

export default Recipes;