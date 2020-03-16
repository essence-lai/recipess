import 'package:flutter/material.dart';
import 'package:recipess/services/auth.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      backgroundColor: Color(0xffECFAF0),
      appBar: AppBar(
        backgroundColor: Color(0xff69EF8D),
        elevation: 0.0,
        title: Text('Sign up to RecipEss'),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0),
                TextFormField(
                  onChanged: (val){
                    setState(() => email = val);
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  obscureText: true,
                  onChanged: (val){
                    setState(() => password = val);
                  },
                ),
                SizedBox(height: 20.0),
                RaisedButton(
                  color: Colors.pinkAccent,
                  child: Text(
                    'Register',
                    style: TextStyle(color: Colors.white)
                  ),
                  onPressed: () async {
                    print(email);
                    print(password);
                  },

                )
              ]
            ),
          ),
        ),
    );
  }
}