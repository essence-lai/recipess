import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipess/modals/users.dart';
import 'package:recipess/screens/home/user_tile.dart';

class UsersList extends StatefulWidget {
  @override
  _UsersListState createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  @override
  Widget build(BuildContext context) {

    final users = Provider.of<List<Users>>(context) ?? [];

    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index){
        return UserTile(user: users[index]);
      },
    );
  }
}