import e = require('express');
import { searchRecipes, MarmitonQueryBuilder, RECIPE_PRICE, RECIPE_DIFFICULTY, RECIPE_TYPE } from 'marmiton-api';

import {Recipe} from "marmiton-api/dist/types/@types/recipe";

function enumConverter(enumName : any, enumType: String) : any{
    switch (enumType){
        case "PRICE":
            return RECIPE_PRICE[enumName];
        case "DIFFICULTY":
            return RECIPE_DIFFICULTY[enumName];
        case "TYPE":
            return enumName as RECIPE_TYPE;
        default:
            break;
    }  
}

class query{
    qb = new MarmitonQueryBuilder();

    constructor(wordsInRecipe?: string, recipePrice?: string, recipeDifficulty?: string, recipeType?:string, cookingTime?: number){
        if(wordsInRecipe){
            this.qb.withTitleContaining(wordsInRecipe)
        }
        if(recipePrice){
            this.qb.withPrice(enumConverter(recipePrice,"PRICE"))
        }
        if(cookingTime){
            this.qb.takingLessThan(cookingTime)
        }
        if(recipeDifficulty){
            this.qb.withDifficulty(enumConverter(recipeDifficulty, "DIFFICULTY"))
        }
        if(recipeType){
            this.qb.withType(enumConverter(recipeType, "TYPE"))
        }
    }

    getQuery():string{
        return this.qb.build();
    }
}

const getRecipes = async (searchParams : Array<string>, numberMax: number) => { 
    let number = numberMax as unknown as number;
    //const q = new query('tarte', 'CHEAP',undefined,"dessert",45);
    const q = new query(searchParams[0], searchParams[1],searchParams[2],searchParams[3],searchParams[4] as unknown as number);

    return await searchRecipes(q.getQuery(), { limit: numberMax });
};

export default getRecipes;

