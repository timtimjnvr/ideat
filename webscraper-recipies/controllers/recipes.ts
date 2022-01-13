import {Request, Response } from "express";
import RequestModule from "framework7/types/modules/request/request";
import getRecipes from "../src/getRecipes";
import recipesConverter from "../src/recipesConverter";

class Recipes {
    verifyParams(req: Request, res: Response){
        if(!(req.query.numberMax)){
            res.status(415).send({"error": "missing mandatory numberMax parameter"}).end();
        }
    }
    
    static async getRecipesHandler(req: Request, res: Response): Promise<void>{
        Recipes.prototype.verifyParams(req,res);
        const numberMax: number = parseInt(String(req.query.numberMax));
        const marmitionRecipes = await getRecipes(numberMax);
        const recipes = await recipesConverter(marmitionRecipes);
        res.status(200).send({recipes}).end();
    }
}

export default Recipes;