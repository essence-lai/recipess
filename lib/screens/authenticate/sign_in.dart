import 'package:flutter/material.dart';
import 'package:recipess/services/auth.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffECFAF0),
      appBar: AppBar(
        backgroundColor: Color(0xff69EF8D),
        elevation: 0.0,
        title: Text('Sign in to RecipEss'),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: RaisedButton(
            child: Text('Sign in Anonymously'),
            onPressed: () async {
              dynamic result = await _auth.signInAnon();

              if(result == null){
                print('error signing in');
            
              } else {
                print('signed in');
                print(result.uid);
              }
            },
          ),
        ),
    );
  }
}