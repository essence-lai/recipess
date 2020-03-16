import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipess/screens/authenticate/authentica.dart';
import 'package:recipess/modals/user.dart';
import 'package:recipess/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    // return authenticate or home
    if (user == null){
      return Authenticate();

    } else {
      return Home();

    }
  }
}