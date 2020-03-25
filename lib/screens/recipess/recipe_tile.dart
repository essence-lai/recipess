import 'package:flutter/material.dart';
import 'package:recipess/modals/recipes.dart';

class RecipeTile extends StatelessWidget {

  final Recipes recipe;
  RecipeTile({ this.recipe });
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child:  Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child:  ListTile(
          title: Text(recipe.name),
          subtitle: Text(recipe.description),
        ),
      ),
    );
  }
}