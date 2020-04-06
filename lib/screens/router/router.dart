import 'package:flutter/material.dart';
import 'package:recipess/modals/destinations.dart';
import 'package:recipess/screens/home/home.dart';
import 'package:recipess/screens/home/my_recipes.dart';
import 'package:recipess/screens/home/settings_form.dart';
import 'package:recipess/screens/recipess/favourites.dart';
import 'package:recipess/screens/recipess/recipess.dart';
import 'package:recipess/services/auth.dart';

class RouteView extends StatefulWidget {
  @override
  _RouteViewState createState() => _RouteViewState();
}

class _RouteViewState extends State<RouteView> with TickerProviderStateMixin<RouteView> {
  int _currentIndex = 1;
  final AuthService _auth = AuthService();

  void _showSettingsPanel(){
    showModalBottomSheet(context: context, builder: (context) {
      return Scaffold(
         appBar: AppBar(centerTitle: true, 
          backgroundColor: Color(0xffECFAF0),
          title: Text('User Settings', textAlign: TextAlign.center, style: TextStyle(color: Colors.black54, fontFamily: 'Champagne', fontWeight: FontWeight.w600, fontSize: 25),),
          leading: Container(),),
        body:  Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: SettingsForm(),
        ),

      );
    });
  }

  void _showRecipePanel() {
    showModalBottomSheet(context: context, builder: (context) {
      return Scaffold(
        appBar: AppBar(centerTitle: true, 
          backgroundColor: Color(0xffECFAF0),
          title: Text('My Recipes', textAlign: TextAlign.center, style: TextStyle(color: Colors.black54, fontFamily: 'Champagne', fontWeight: FontWeight.w600, fontSize: 25),),
          leading: Container(),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: Tooltip(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal:20),
                margin: EdgeInsets.all(10),
                showDuration: Duration( seconds: 20),
                message: 'If you want remove a recipe \n\n Simply swipe left on the recipe!!',
                child: Icon(Icons.help_outline, color: Colors.grey,),
              )
            )
          ],
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          child: MyRecipes(),
        )

      );
    });
  }

  Future _choiceAction(String choice) async {
    if (choice == 'settings'){
      _showSettingsPanel();
    } else if ( choice == 'myRecipes'){
      _showRecipePanel();
    } else if ( choice == 'signout'){
      await _auth.signOut();    
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffECFAF0),
      appBar: AppBar(
        title: Text('RecipEss',
        style: TextStyle(color: Colors.greenAccent, 
        fontSize: 45,
        fontFamily: "EyeCatchingPro")),
        centerTitle: true,
        backgroundColor: Color(0xffECFAF0),
        elevation: 0.0,
        actions: <Widget>[
          PopupMenuButton(
            icon: Icon(Icons.more_vert, color: Colors.grey),
            color: Colors.white,
            onSelected: _choiceAction,
            itemBuilder: ( BuildContext context) => [
              const PopupMenuItem(
                child: ListTile(trailing: Icon(Icons.face), title: Text('My Recipes')),
                value: 'myRecipes'
              ),
              const PopupMenuItem(
                child: ListTile(trailing: Icon(Icons.settings), title: Text('Settings')),
                value: 'settings',
              ),
              const PopupMenuItem(
                child: ListTile(trailing: Icon(Icons.exit_to_app), title: Text('Logout')),
                value: 'signout',
              ),
            ]
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: IndexedStack(
          index: _currentIndex,
          children: <Widget>[
            Recipess(),
            Favourites(),
            Home(),
          ],
        )
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: allDestinations.map((Destination destination) {
        return BottomNavigationBarItem(
          icon: Icon(destination.icon),
          backgroundColor: Colors.white,
          title: Text(destination.title),
        );
        }).toList(),
      ),
    );
  }
}