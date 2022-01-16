import { stringLiteral, tsParameterProperty } from "@babel/types";
import {Request, Response } from "express";
import RequestModule from "framework7/types/modules/request/request";
import { RECIPE_TYPE } from "marmiton-api";
import getRecipes from "../src/getRecipes";
import recipesConverter from "../src/recipesConverter";

var availableRecipePrices: Array<string> = ['CHEAP', 'EXPENSIVE','MEDIUM'];
var availableRecipesDificulties : Array<string> = ['EASY', 'MEDIUM', 'HARD', 'VERY_HARD'];
var availableRecipeType: Array<string> = ["conseil", "boisson","confiserie","dessert","platprincipal","sauce", "accompagnement", "entree"];

class Recipes {

    verifyParam(paramValue: string , availablePossibilities : Array<string>) : boolean{
        if(availablePossibilities.includes(paramValue) || !paramValue){
            return true;
        }else{
            return false;
        }
    }

    verifyParams(req: Request, res: Response): Array<string>{
        
        let budget, name,recipeType, recipePrice, recipeDifficulty, cookingTime;
        let searchParameters : Array<string> = [];
        req.query.name ? name = req.query.name as string : undefined;
        req.query.recipePrice ? recipePrice = req.query.recipePrice as string : undefined;
        req.query.recipeDifficulty ? recipeDifficulty = req.query.recipeDifficulty as string : undefined;
        req.query.recipeType ? recipeType = req.query.recipeType as string : undefined;
        req.query.cookingTime ? cookingTime = req.query.cookingTime as string : 120;
        
        let  errorMsg : string = "";
        !this.verifyParam(recipePrice, availableRecipePrices) ? errorMsg = errorMsg + recipePrice  +" for parameter recipePrice is invalid / ":"";
        !this.verifyParam(recipeDifficulty, availableRecipesDificulties) ? errorMsg = errorMsg + recipeDifficulty  +" for parameter recipeDifficulty is invalid / ":"";
        !this.verifyParam(recipeType, availableRecipeType) ? errorMsg = errorMsg + recipeType  +" for parameter recipeType is invalid /" : ""; 
        console.log(name, recipePrice,recipeDifficulty,recipeType, cookingTime);
        if(!errorMsg){
            return [name, recipePrice,recipeDifficulty,recipeType, cookingTime];
        }
        else{
            return [errorMsg];
        }
    }
    
    static async getRecipesHandler(req: Request, res: Response): Promise<void>{
        console.log("[INFO] GET /recipes");
        const searchParameters : Array<string> =  Recipes.prototype.verifyParams(req,res);
        if(searchParameters.length ==1){
            //error in parameters
            res.status(415).send({"error": searchParameters[0]}).end();
            return null
        }
        const numberMax: number = parseInt(String(req.query.numberMax));
        const marmitionRecipes = await getRecipes(searchParameters, numberMax);
        const recipes = await recipesConverter(marmitionRecipes);
        res.status(200).send({recipes}).end();
        return null;
    }
}

export default Recipes;