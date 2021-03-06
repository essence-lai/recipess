import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipess/modals/recipes.dart';
import 'package:recipess/screens/recipess/favourites_list.dart';
import 'package:recipess/services/database.dart';

class Favourites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Recipes>>.value(
      value: DatabaseService().recipes,
      child:  Scaffold(
      backgroundColor: Color(0xffECFAF0),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              colorFilter: ColorFilter.mode(Colors.white.withOpacity(0.03), BlendMode.dstATop),
              image: AssetImage('assets/hearts.png'),
            )
          ),
          child: FavouriteList()
      ),
    ) 
    );
  }
}