import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipess/modals/recipes.dart';
import 'package:recipess/screens/recipess/recipe-details.dart';
import 'package:recipess/screens/recipess/recipe_tile.dart';

class RecipesList extends StatefulWidget {
  @override
  _RecipesListState createState() => _RecipesListState();
}

class _RecipesListState extends State<RecipesList> {
  @override
  Widget build(BuildContext context) {

    final recipes = Provider.of<List<Recipes>>(context) ?? [];
    
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: recipes.length,
      itemBuilder: (context, index){
        return GestureDetector(
          onTap: () { 
            Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RecipeDetails(recipe: recipes[index], fraction: 1))
          );
          },
          onLongPress: () {print('set favourite');},
          child: RecipeTile(recipe: recipes[index])
        );
      },
    );
  }
}