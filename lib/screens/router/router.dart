import 'package:flutter/material.dart';
import 'package:recipess/modals/destinations.dart';
import 'package:recipess/screens/home/home.dart';
import 'package:recipess/screens/home/settings_form.dart';
import 'package:recipess/screens/recipess/recipess.dart';
import 'package:recipess/services/auth.dart';

class RouteView extends StatefulWidget {
  @override
  _RouteViewState createState() => _RouteViewState();
}

class _RouteViewState extends State<RouteView> with TickerProviderStateMixin<RouteView> {
  int _currentIndex = 0;
  final AuthService _auth = AuthService();

  void _showSettingsPanel(){
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: SettingsForm(),
        );
      });
    }

    Future _choiceAction(String choice) async {
      if (choice == 'settings'){
        _showSettingsPanel();
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