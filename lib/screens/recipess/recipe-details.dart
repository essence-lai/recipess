
import 'package:flutter/material.dart';
import 'package:recipess/modals/recipes.dart';
import 'package:recipess/screens/recipess/ingredient-details.dart';
import 'package:recipess/screens/recipess/instruction-details.dart';
import 'dart:math';

class RecipeDetails extends StatelessWidget {
  final Recipes recipe;
  RecipeDetails({this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Color(0xffECFAF0),
      body: CustomScrollView(
        slivers: <Widget>[
            SliverAppBar(
              iconTheme: IconThemeData(color: Colors.white),
              backgroundColor: Colors.green[400],
              pinned: true,
              expandedHeight: 250.0,
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
                      ),),
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
                              ),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  children: <Widget>[
                                    Icon(Icons.directions_run, color: Colors.orange[100]),
                                    SizedBox(height: 6.0),
                                    Text('${recipe.calories ?? '...'} Calories', style: TextStyle(color: Colors.grey)),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ),
                      SizedBox(height: 20.0),
                      Text('What you will need', style: TextStyle(fontFamily: "Champagne", fontSize: 30)),
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
                    return IngredientDetail(checked: false, ingredient: ingredient);
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
                              alignment: Alignment(0.3,0.0),
                              child:  Text('Let\'s Get Started', style: TextStyle(fontFamily: "Champagne", fontSize: 30, fontWeight: FontWeight.w600)),
                            ),
                            trailing: Padding(
                              padding: EdgeInsets.only(right: 16.0),
                              child: Tooltip(
                                padding: EdgeInsets.symmetric(vertical: 20, horizontal:20),
                                margin: EdgeInsets.all(10),
                                showDuration: Duration( seconds: 20),
                                message: 'To cross off a step, you can swipe on the step or tap the checkbox!',
                                child: Icon(Icons.help_outline),
                              )
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
                    return Container( color: Colors.white, height: 45.0 );
                  },
                  childCount: max(10 - recipe.ingredients.length, 0)
                ),
            )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          recipe.prepTime == 20 ? Icons.favorite : Icons.favorite_border,
          color: recipe.prepTime == 20? Colors.red : null,
        ),
        backgroundColor: Colors.greenAccent,
        onPressed: () {
          print('setFavourite');
        },
      ),
    );
  }
}