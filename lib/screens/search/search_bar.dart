import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/material.dart';
import 'package:recipess/modals/recipes.dart';
import 'package:recipess/screens/recipess/recipe-details.dart';
import 'package:recipess/screens/recipess/recipe_tile.dart';
import 'package:recipess/screens/recipess/recipes_list.dart';
import 'package:recipess/screens/search/search_service.dart';
import 'package:recipess/shared/loading.dart';

class RecipeSearchBar extends StatefulWidget {
  @override
  _RecipeSearchBarState createState() => _RecipeSearchBarState();
}

class _RecipeSearchBarState extends State<RecipeSearchBar> {
  var queryResultSet = [];
  var tempSearchStore =[];

  initiateSearch(String value) async {
    if(tempSearchStore.length > 0){
      if(!tempSearchStore[0].name.toString().toLowerCase().startsWith(value.substring(0,1).toLowerCase())){
        setState(() {
          queryResultSet = [];
          tempSearchStore = [];
        });
      }
    }


    if(queryResultSet.length == 0){
      SearchService().searchByName(value.substring(0,1)).then((QuerySnapshot docs) {
        for(int i = 0; i < docs.documents.length; ++i) {
          setState(() {
            queryResultSet.add(
              Recipes(
                uid: docs.documents[i].documentID,
                name: docs.documents[i]['name'],
                description: docs.documents[i]['description'],
                ingredients: docs.documents[i]['ingredients'],
                instructions: docs.documents[i]['instructions'],
                servings: docs.documents[i]['servings'],
                calories: docs.documents[i]['calories'],
                prepTime: docs.documents[i]['prepTime'],
                cookTime: docs.documents[i]['cookTime'],
                searchKey: docs.documents[i]['searchKey'],
              )
          );
          tempSearchStore = [];
          });

        
          queryResultSet.forEach((element){
            if(element.name.toString().toLowerCase().startsWith(value.toLowerCase())) {
              setState(() {
                tempSearchStore.add(element);
              });
            }
          });
        }
      });
    } else {
       tempSearchStore = [];
        queryResultSet.forEach((element){
          if(element.name.toString().toLowerCase().startsWith(value.toLowerCase())) {
            setState(() {
              tempSearchStore.add(element);
            });
          }
        });
    }


  }
  
  @override
  Widget build(BuildContext context) {
    Future <List<Recipes>> search(String search) async {
        await initiateSearch(search);
        await Future.delayed(Duration(seconds: 2));

        return List.generate(tempSearchStore.length, (int index){
          return tempSearchStore[index];
        });
    }

    return Container(
      child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SearchBar(
          minimumChars: 1,
          onSearch: search,
          loader: Loading(),
          debounceDuration: Duration(milliseconds: 800),
          searchBarStyle: SearchBarStyle(
            backgroundColor: Colors.white54,
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            borderRadius: BorderRadius.circular(40)
          ),
      
          placeHolder: RecipesList(),
          onItemFound: (Recipes recipe, int index){
            return GestureDetector(
              onTap: () { 
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RecipeDetails(recipe: recipe, fraction: 1))
              );
              },
              child: RecipeTile(recipe: recipe)
            );
          },
        )
      )
    );
  }
}