import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipess/modals/recipes.dart';
import 'package:recipess/modals/user.dart';
import 'package:recipess/services/database.dart';
import 'package:recipess/shared/loading.dart';

class RecipeTile extends StatelessWidget {
  final Recipes recipe;
  final bool favourite = false;
  RecipeTile({this.recipe});

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return StreamBuilder<UserData> (
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot){
        if(snapshot.hasData){
          UserData userData = snapshot.data;

          List<dynamic> _favourites = new List<dynamic>.from(userData.favourites);

          return Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Card(
                margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 6.0),
                    ListTile(
                      title: Text(
                          '${recipe.name[0].toUpperCase()}${recipe.name.substring(1)}',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.green[600],
                              fontSize: 35,
                              fontFamily: "Champagne")),
                      subtitle: Text(
                        recipe.description,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: Padding( 
                        padding: EdgeInsets.only(bottom: 20.0),
                        child: Icon(
                           _favourites.contains(recipe.uid) ? Icons.favorite : Icons.favorite_border,
                          color: _favourites.contains(recipe.uid) ? Colors.red : null,
                        ),
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
        return Loading();
      },

    );
  }
}
