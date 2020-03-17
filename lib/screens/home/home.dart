import 'package:flutter/material.dart';
import 'package:recipess/services/auth.dart';
import 'package:recipess/services/database.dart';
import 'package:provider/provider.dart';
import 'package:recipess/screens/home/users_list.dart';
import 'package:recipess/modals/users.dart';
import 'package:recipess/screens/home/settings_form.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

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

    return StreamProvider<List<Users>>.value(
      value: DatabaseService().users,
      child: Scaffold(
        backgroundColor: Color(0xffECFAF0),
        appBar: AppBar(
          title: Text('RecipEss'),
          centerTitle: true,
          backgroundColor: Color(0xffECFAF0),
          elevation: 0.0,
          actions: <Widget>[
            PopupMenuButton(
              color: Colors.white,
              onSelected: _choiceAction,
              itemBuilder: ( BuildContext context) => [
                const PopupMenuItem(
                  child: Text('Settings'),
                  value: 'settings',
                 ),
                 const PopupMenuItem(
                  child: Text('Logout'),
                  value: 'signout',
                 ),
              ]
            ),
          ],
        ),
        body: Container (
          decoration: BoxDecoration(
            image: DecorationImage(
              colorFilter: ColorFilter.mode(Colors.white.withOpacity(0.03), BlendMode.dstATop),
              image: AssetImage('assets/background.png'),
            )
          ),
          child: UsersList()
        ),
      )
    );
  }
}