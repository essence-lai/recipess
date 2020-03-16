import 'package:flutter/material.dart';
import 'package:recipess/services/auth.dart';
import 'package:recipess/services/database.dart';
import 'package:provider/provider.dart';
import 'package:recipess/screens/home/users_list.dart';
import 'package:recipess/modals/users.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
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
            )
          ],
        ),
        body: UsersList(),
      )
    );
  }
}