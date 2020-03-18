import 'package:flutter/material.dart';
import 'package:recipess/services/database.dart';
import 'package:provider/provider.dart';
import 'package:recipess/screens/home/users_list.dart';
import 'package:recipess/modals/users.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


    return StreamProvider<List<Users>>.value(
      value: DatabaseService().users,
      child: Container (
          decoration: BoxDecoration(
            image: DecorationImage(
              colorFilter: ColorFilter.mode(Colors.white.withOpacity(0.03), BlendMode.dstATop),
              image: AssetImage('assets/community.png'),
            )
          ),
          child: UsersList()
      ),
    );
  }
}