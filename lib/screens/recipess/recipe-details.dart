
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:recipess/modals/recipes.dart';
import 'package:recipess/modals/user.dart';
import 'package:recipess/screens/recipess/ingredient-details.dart';
import 'package:recipess/screens/recipess/instruction-details.dart';
import 'dart:math';
import 'package:recipess/services/database.dart';
import 'package:recipess/shared/loading.dart';


class RecipeDetails extends StatefulWidget{
  final Recipes recipe;
  final double fraction;
  RecipeDetails({this.recipe, this.fraction});

  @override
  _RecipeDetails createState() => _RecipeDetails(recipe: this.recipe, fraction: fraction);
}

class _RecipeDetails extends State<RecipeDetails> {
  final Recipes recipe;
  double fraction;
  _RecipeDetails({this.recipe, this.fraction});


  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return StreamBuilder<UserData> (
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context,snapshot) {
        if(snapshot.hasData){
          UserData userData = snapshot.data;

          List<dynamic> _favourites = new List<dynamic>.from(userData.favourites);

           return Scaffold(
            backgroundColor:  Color(0xffECFAF0),
            body: CustomScrollView(
              slivers: <Widget>[
                  SliverAppBar(
                    iconTheme: IconThemeData(color: Colors.white),
                    backgroundColor: Colors.green[400],
                    pinned: true,
                    expandedHeight: 250.0,
                    actions: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(right: 16.0),
                        child: Tooltip(
                          padding: EdgeInsets.symmetric(vertical: 20, horizontal:20),
                          margin: EdgeInsets.all(10),
                          showDuration: Duration( seconds: 20),
                          message: 'Use the Slider to change the portions of your recipe! \n\nTo cross off an ingredient or step, you can swipe on the ingredient or tap the checkbox!',
                          child: Icon(Icons.help_outline),
                        )
                      )
                    ],
                    flexibleSpace: FlexibleSpaceBar(
                      stretchModes: <StretchMode>[
                        StretchMode.zoomBackground,
                        StretchMode.blurBackground,
                        StretchMode.fadeTitle,
                      ],
                      title: Text('${recipe.name[0].toUpperCase()}${recipe.name.substring(1)}',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Champagne",
                            fontWeight: FontWeight.bold
                            )),
                      background: Stack(
                        fit: StackFit.expand,
                        children: <Widget>[
                          Image(
                            image: AssetImage('assets/cooking.png'),
                            fit: BoxFit.cover,
                            color: Colors.white.withOpacity(0.10),
                          )
                        ],
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, index) {
                        return Column(
                          children: <Widget>[
                            Center(child: Container(
                                color: Colors.green[400],
                                width: 9999,
                                padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
                                child: Text('${recipe.description}', style: TextStyle(color: Colors.white, backgroundColor: Colors.green[400]))
                              ),
                            ),
                            Slider(
                                value: fraction,
                                activeColor: Colors.green[600],
                                inactiveColor: Colors.white,
                                min: 0.50,
                                max: 2.0,
                                divisions: 3,
                                onChanged: (val) => setState(() => fraction = val ),
                                label: '$fraction',
                              ),
                            
                            Card(
                              margin: EdgeInsets.fromLTRB(6.0, 6.0, 6.0, 0.0),
                              child:  Padding(
                                padding: EdgeInsets.symmetric( vertical: 20.0, horizontal: 00.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        children: <Widget>[
                                          Icon(Icons.av_timer, color: Colors.lightBlue[100]),
                                          SizedBox(height: 6.0),
                                          Text('${(recipe.prepTime + 10*fraction - 10).round()} Prep Time', style: TextStyle(color: Colors.grey)),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        children: <Widget>[
                                          Icon(Icons.update, color: Colors.red[100]),
                                          SizedBox(height: 6.0),
                                          Text('${(recipe.prepTime + 10*fraction - 10).round()} Cook Time', style: TextStyle(color: Colors.grey)),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        children: <Widget>[
                                          Icon(Icons.restaurant, color: Colors.green[100]),
                                          SizedBox(height: 6.0),
                                          Text('${(recipe.servings*fraction).round()} Servings', style: TextStyle(color: Colors.grey)),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        children: <Widget>[
                                          Icon(Icons.directions_run, color: Colors.orange[100]),
                                          SizedBox(height: 6.0),
                                          Text('${ recipe.calories != null ? (recipe.calories*fraction).round() : '...'} Calories', style: TextStyle(color: Colors.grey)),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ),
                            SizedBox(height: 20.0),
                            Text('What you will need', style: TextStyle(fontFamily: "Champagne", fontSize: 30,  fontWeight: FontWeight.w600)),
                            SizedBox(height: 20.0),
                          ],
                        );
                      },
                      childCount: 1,
                  ),
                  ),
                  SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, index) {
                          Map<String, dynamic> ingredient = Map<String, dynamic>.from(recipe.ingredients[index]);
                          return IngredientDetail(checked: false, ingredient: ingredient, fraction: fraction);
                        },
                        childCount: recipe.ingredients.length
                      ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, index) {
                        return  Column(
                          children: <Widget>[
                            SizedBox(height: 20.0),
                            DecoratedBox(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:  BorderRadius.only(
                                  topLeft: Radius.circular(40.0),
                                  topRight: Radius.circular(40.0)
                                ),
                              ) ,
                              child:  Padding(
                                padding: EdgeInsets.only(top: 10),
                                child: ListTile(
                                  title: Align(
                                    alignment: Alignment(0.0,0.0),
                                    child:  Text('Let\'s Get Started', style: TextStyle(fontFamily: "Champagne", fontSize: 30, fontWeight: FontWeight.w600)),
                                  )
                                )
                              )
                            )
                          ],
                        );
                      },
                      childCount: 1
                    ),
                  ),
                  SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, index) {
                          Map<String, dynamic> instruction = Map<String, dynamic>.from(recipe.instructions[index]);
                          return InstructionDetail(checked: false, instruction: instruction);
                        },
                        childCount: recipe.ingredients.length
                      ),
                  ),
                  SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, index) {
                          return Container( 
                            color: Colors.white, 
                            height: 450.0,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                              child: Column(
                                children: <Widget>[
                                  SizedBox(height: 100.0),
                                  GestureDetector(
                                    onTap: () async {
                                      if(_favourites.contains(recipe.uid)) {
                                        _favourites.removeWhere((favourite) =>  favourite == recipe.uid);
                                      } else {
                                        _favourites.add(recipe.uid);
                                      }
                                      
                                      await DatabaseService(uid: user.uid).updateUserData(userData.name, userData.mood, userData.hunger, _favourites);
                                    },
                                    child: SpinKitPumpingHeart(
                                      color: Colors.pinkAccent,
                                      size: 50.0
                                    ),
                                  ),
                                  SizedBox(height: 20.0),
                                  Text('WooHoo, You Did it!', style: TextStyle(fontWeight: FontWeight.w600, fontFamily: 'Champagne', fontSize: 25 )),
                                  Text('Did you enjoy this recipe?', style: TextStyle( fontFamily: 'Champagne', fontSize: 25 )),
                                  Text('Click a heart to add it!', style: TextStyle(fontWeight: FontWeight.w600, fontFamily: 'Champagne', fontSize: 25 )),
                                ],
                              ),
                            )

                            );
                        },
                        childCount: 1
                      ),
                  )
              ],
            ),
            floatingActionButton: FloatingActionButton(
              child: Icon(
                _favourites.contains(recipe.uid)? Icons.favorite : Icons.favorite_border,
                color: _favourites.contains(recipe.uid) ? Colors.red : null,
              ),
              backgroundColor: Colors.greenAccent,
              onPressed: () async {
                
                if(_favourites.contains(recipe.uid)) {
                  _favourites.removeWhere((favourite) =>  favourite == recipe.uid);
                } else {
                  _favourites.add(recipe.uid);
                }
                
                await DatabaseService(uid: user.uid).updateUserData(userData.name, userData.mood, userData.hunger, _favourites);
              },
            ),
          );
        }
        return Loading();
      }
    );
  }
}