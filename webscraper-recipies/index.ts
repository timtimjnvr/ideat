import { searchRecipes, MarmitonQueryBuilder, RECIPE_PRICE, RECIPE_DIFFICULTY } from 'marmiton-api';

import {Recipe} from "marmiton-api/dist/types/@types/recipe";

// A query builder is provided to make complex queries
const qb = new MarmitonQueryBuilder();
const query = qb
    //.withTitleContaining('sauce étudiante')
    //.withoutOven()
    //.withPrice(RECIPE_PRICE.CHEAP)
    //.takingLessThan()
    //.withDifficulty(RECIPE_DIFFICULTY.EASY)
    .build()

const recipes = async () => {
    return await searchRecipes(query, { limit: 10 });
};

(async () => {
    try {
        var recipies = await recipes();
        console.log(recipies);
    } catch (e) {
        // Deal with the fact the chain failed
    }
})();
