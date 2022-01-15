import { stringLiteral, tsParameterProperty } from "@babel/types";
import {Request, Response } from "express";
import RequestModule from "framework7/types/modules/request/request";
import getRecipes from "../src/getRecipes";
import recipesConverter from "../src/recipesConverter";

var availableRecipePrices = ['CHEAP', 'EXPENSIVE','MEDIUM'];
var availableRecipesDificulties = ['EASY', 'MEDIUM', 'HARD', 'VERY_HARD'];
var avalableRecipeType= ['ADVICE', 'BEVERAGE','CANDY','DESSERT','MAIN_COURSE','SAUCE','SIDE_DISH','STARTER'];

class Recipes {
    verifyParams(req: Request, res: Response){
        let budget, name, recipePrice, recipeDifficulty, cookingTime

        if(!(req.query.budget)){
            res.status(415).send({"error": "missing mandatory budget parameter"}).end();
        }
    }
    
    static async getRecipesHandler(req: Request, res: Response): Promise<void>{
        console.log("[INFO] GET /recipes")
        Recipes.prototype.verifyParams(req,res);
        const numberMax: number = parseInt(String(req.query.numberMax));
        const marmitionRecipes = await getRecipes(numberMax);
        const recipes = await recipesConverter(marmitionRecipes);
        res.status(200).send({recipes}).end();
    }
}

export default Recipes;