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

    return StreamProvider<List<Users>>.value(
      value: DatabaseService().users,
      child: Scaffold(
        backgroundColor: Color(0xffECFAF0),
        appBar: AppBar(
          title: Text('RecipEss'),
          backgroundColor: Color(0xffECFAF0),
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('Logout'),
              onPressed: () async {
                await _auth.signOut();
              }
            ),
            FlatButton.icon(
              icon: Icon(Icons.settings),
              label: Text('settings'),
              onPressed: () => _showSettingsPanel(),
            ),
          ],
        ),
        body: UsersList(),
      )
    );
  }
}