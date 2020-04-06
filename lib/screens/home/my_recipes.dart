import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipess/modals/recipes.dart';
import 'package:recipess/modals/user.dart';
import 'package:recipess/screens/recipess/recipe-details.dart';
import 'package:recipess/screens/recipess/recipe_tile.dart';
import 'package:recipess/services/database.dart';

class MyRecipes extends StatefulWidget {
  @override
  _MyRecipesState createState() => _MyRecipesState();
}

class _MyRecipesState extends State<MyRecipes> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    
    return StreamBuilder<List<Recipes>>(
      stream: DatabaseService(uid: user.uid).myRecipes,
      builder: (context, snapshot) {
        
        return ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: snapshot.data.length,
          itemBuilder: (context, index){
            return Dismissible(
              key: Key(index.toString()), 
              background: Container(
                color: Colors.white
              ),
              secondaryBackground: Container(
                color: Colors.pink[200],
                child: Align(
                  alignment: Alignment(0.85, 0),
                  child: Icon(Icons.delete_outline)
                )
              ),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) async  {
                  await DatabaseService(uid: user.uid).removeRecipe(snapshot.data[index].uid);
                  setState(() {
                    snapshot.data.removeAt(index);
                  });            
              },
              child: GestureDetector(
                  onTap: () { 
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RecipeDetails(recipe: snapshot.data[index], fraction: 1))
                  );
                  },
                  child: RecipeTile(recipe: snapshot.data[index])
                )
              
              );
          },
        );

      }
    );
  }
}