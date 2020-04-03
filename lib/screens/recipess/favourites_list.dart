import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipess/modals/recipes.dart';
import 'package:recipess/modals/user.dart';
import 'package:recipess/screens/recipess/recipe-details.dart';
import 'package:recipess/screens/recipess/recipe_tile.dart';
import 'package:recipess/screens/recipess/recipess.dart';
import 'package:recipess/services/database.dart';
import 'package:recipess/shared/loading.dart';

class FavouriteList extends StatefulWidget {
  @override
  _FavouriteListState createState() => _FavouriteListState();
}

class _FavouriteListState extends State<FavouriteList> {
  @override
  Widget build(BuildContext context) {

    final recipes = Provider.of<List<Recipes>>(context) ?? [];
    final user = Provider.of<User>(context);
    List<Recipes> userFavourites = [];


    return StreamBuilder<UserData> (
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context,snapshot){
        if(snapshot.hasData){
          UserData userData = snapshot.data;

          List<dynamic> _favourites = new List<dynamic>.from(userData.favourites);

          for(Recipes recipe in recipes){
            if( _favourites.contains(recipe.uid) && !userFavourites.contains(recipe)){
              userFavourites.add(recipe);
            }
          }

          if ( userFavourites.length > 0 ) {
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: userFavourites.length,
              itemBuilder: (context, index){
                return GestureDetector(
                  onTap: () { 
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RecipeDetails(recipe: userFavourites[index], fraction: 1))
                  );
                  },
                  child: RecipeTile(recipe: userFavourites[index])
                );
              },
            );
          } else {
            return Align(
              alignment: Alignment(0.0,-0.5),
                child: Opacity(
                  opacity: 0.6,
                  child: Container(
                    height: 250,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        colorFilter: ColorFilter.mode(Colors.white.withOpacity(0.03), BlendMode.dstATop),
                        image: AssetImage('assets/hunger.png'),
                      ),
                      color: Colors.white,
                      borderRadius:  BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        topRight: Radius.circular(40.0),
                        bottomLeft: Radius.circular(40.0),
                        bottomRight: Radius.circular(40.0)
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 80.0),
                          Text('No favourites yet?', style: TextStyle(fontFamily: 'Champagne', fontSize: 25)),
                          Text('Try out some recipes!', style: TextStyle(fontFamily: 'Champagne', fontSize: 25))
                        ],
                      )
                    )
                  ),
                )
              );
          }

          }
          return Loading();
        }
      );
  }
}