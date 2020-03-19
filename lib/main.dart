import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipess/screens/wrapper.dart';
import 'package:recipess/services/auth.dart';
import 'package:recipess/modals/user.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
        value: AuthService().user,
        child: MaterialApp(
          theme: ThemeData(
            // Define the default brightness and colors.
            brightness: Brightness.light,
            primaryColor: Colors.greenAccent,
            accentColor: Color(0xffECFAF0),
            primaryTextTheme:  TextTheme(
              title: TextStyle(color: Colors.grey),
            ),
            accentTextTheme: TextTheme(
              title: TextStyle(color: Colors.pinkAccent),
            ),


            // Define the default font family.
            fontFamily: 'Lexend Deca',

            // Define the default TextTheme. Use this to specify the default
            // text styling for headlines, titles, bodies of text, and more.
            textTheme: TextTheme(
              headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
              title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
              body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
            ),       
          ),
          home: Wrapper(),
        ),
    );
  }
}