import { searchRecipes, MarmitonQueryBuilder, RECIPE_PRICE, RECIPE_DIFFICULTY } from 'marmiton-api';

import {Recipe} from "marmiton-api/dist/types/@types/recipe";

// A query builder is provided to make complex queries
const qb = new MarmitonQueryBuilder();
const query = (wordsInRecipe: string) => {
    return (
        qb
        .withTitleContaining(wordsInRecipe)
        //.withoutOven()
        //.withPrice(RECIPE_PRICE.CHEAP)
        //.takingLessThan()
        //.withDifficulty(RECIPE_DIFFICULTY.EASY)
        .build())
}
const getRecipes = async () => { 
    return await searchRecipes(query('tarte aux pommes'), { limit: 10 });
};

(async () => {
    try {
        var recipies = await getRecipes();
        //console.log(recipies);
    } catch (e) {
        // Deal with the fact the chain failed
    }
})();

export default getRecipes;
