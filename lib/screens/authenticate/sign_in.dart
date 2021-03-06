import 'package:flutter/material.dart';
import 'package:recipess/services/auth.dart';
import 'package:recipess/shared/constants.dart';
import 'package:recipess/shared/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({ this.toggleView });

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Color(0xffECFAF0),
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        elevation: 0.0,
        centerTitle: true,
        title: Text('Sign in',
        style: TextStyle(color: Color(0xffECFAF0))),
        actions: <Widget>[
          FlatButton.icon(onPressed: () {
            widget.toggleView();
          }, icon: Icon(Icons.person, color: Color(0xffECFAF0)),
           label: Text('Register', 
           style: TextStyle(color: Color(0xffECFAF0))))
        ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              colorFilter: ColorFilter.mode(Colors.white.withOpacity(0.03), BlendMode.dstATop),
              image: AssetImage('assets/community.png'),
            )
          ),
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0),
                Text('RecipEss',
                 style: TextStyle(color: Colors.greenAccent, 
                 fontSize: 80,
                 fontFamily: "EyeCatchingPro")),
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Email'),
                  validator: (val) => val.isEmpty ? 'Enter an email' : null,
                  onChanged: (val){
                    setState(() => email = val);
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Password'),
                  validator: (val) => val.length < 6 ? 'Password must contain 6+ characters long' : null,
                  obscureText: true,
                  onChanged: (val){
                    setState(() => password = val);
                  },
                ),
                SizedBox(height: 20.0),
                RaisedButton(
                  color: Colors.pinkAccent,
                  child: Text(
                    'Sign In',
                    style: TextStyle(color: Colors.white)
                  ),
                  onPressed: () async {
                   if(_formKey.currentState.validate()){
                     setState(() => loading = true);
                     dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                      if(result == null) {
                        setState(() { 
                          error = 'Could not sign in';
                          loading = false;
                        });
                      }
                    }
                  },
                ),
                SizedBox(height: 12.0),
                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 14.0),
                )

              ]
            ),
          ),
        ),
    );
  }
}