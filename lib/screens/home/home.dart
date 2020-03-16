import 'package:flutter/material.dart';
import 'package:recipess/services/auth.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffECFAF0),
        appBar: AppBar(
          title: Text('RecipEss'),
          backgroundColor: Color(0xff69EF8D),
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
      );
  }
}