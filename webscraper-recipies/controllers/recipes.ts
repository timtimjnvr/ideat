import {Request, Response } from "express";
import RequestModule from "framework7/types/modules/request/request";
import getRecipes from "../src/getRecipes";
import recipesConverter from "../src/recipesConverter";

class Recipes {
    verifyParams(req: Request, res: Response){
        if(!(req.body.budget && req.body.numberMax)){
            res.status(415).send({"error": "missing mandatory parameter"}).end();
        }
    }
    
    static async getRecipesHandler(req: Request, res: Response): Promise<void>{
        Recipes.prototype.verifyParams(req,res);
        const marmitionRecipes = await getRecipes(100);
        const recipes = await recipesConverter(marmitionRecipes)
        //console.log(recipes);
        res.status(200).send({recipes}).end();
    }
}

export default Recipes;