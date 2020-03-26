import 'package:flutter/material.dart';
import 'package:recipess/modals/recipes.dart';

class RecipeTile extends StatelessWidget {
  final Recipes recipe;
  bool favourite = false;
  RecipeTile({this.recipe});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
          margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text(
                    '${recipe.name[0].toUpperCase()}${recipe.name.substring(1)}',
                    style: TextStyle(
                        color: Colors.greenAccent,
                        fontSize: 45,
                        fontFamily: "EyeCatchingPro")),
                subtitle: Text(
                  recipe.description,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: IconButton(
                  icon: Icon(
                    recipe.prepTime == 20 ? Icons.favorite : Icons.favorite_border,
                    color: recipe.prepTime == 20? Colors.red : null,
                  ),
                  onPressed: () {
                    favourite = !favourite;
                  },
                ),
              ),
              SizedBox(height: 6.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: <Widget>[
                        Icon(Icons.av_timer, color: Colors.grey),
                        SizedBox(height: 6.0),
                        Text('${recipe.prepTime} Prep Time'),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: <Widget>[
                        Icon(Icons.update, color: Colors.grey),
                        SizedBox(height: 6.0),
                        Text('${recipe.cookTime} Cook Time'),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: <Widget>[
                        Icon(Icons.restaurant, color: Colors.grey),
                        SizedBox(height: 6.0),
                        Text('${recipe.servings} Servings'),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 16.0),
            ],
          )),
    );
  }
}
