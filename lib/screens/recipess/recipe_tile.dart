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
                        color: Colors.green[600],
                        fontSize: 55,
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
                        Icon(Icons.av_timer, color: Colors.lightBlue[100]),
                        SizedBox(height: 6.0),
                        Text('${recipe.prepTime} Prep Time', style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: <Widget>[
                        Icon(Icons.update, color: Colors.red[100]),
                        SizedBox(height: 6.0),
                        Text('${recipe.cookTime} Cook Time', style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: <Widget>[
                        Icon(Icons.restaurant, color: Colors.green[100]),
                        SizedBox(height: 6.0),
                        Text('${recipe.servings} Servings', style: TextStyle(color: Colors.grey)),
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
