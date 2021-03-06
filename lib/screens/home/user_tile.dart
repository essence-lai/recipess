import 'package:flutter/material.dart';
import 'package:recipess/modals/users.dart';

class UserTile extends StatelessWidget {

  final Users user;
  UserTile({ this.user });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.primaries[user.hunger],
            backgroundImage: AssetImage('assets/hunger.png'),
            ),
          title: Text(user.name),
          subtitle: Text('Current Mood: ' + user.mood),
        ),
      )
    );
  }
}