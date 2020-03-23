import 'package:flutter/material.dart';
import 'package:recipess/screens/recipess/add_recipes.dart';

class Recipess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: Colors.greenAccent,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddRecipes())
          );
        },
      ),
      backgroundColor: Color(0xffECFAF0),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              colorFilter: ColorFilter.mode(Colors.white.withOpacity(0.03), BlendMode.dstATop),
              image: AssetImage('assets/hunger.png'),
            )
          ),
      ),
    );
  }
}