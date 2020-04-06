import 'package:flutter/material.dart';
import 'package:recipess/modals/user.dart';
import 'package:recipess/services/database.dart';
import 'package:recipess/shared/constants.dart';
import 'package:provider/provider.dart';
import 'package:recipess/shared/loading.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formKey = GlobalKey<FormState>();
  final List<String> moods = [ 'sad', 'okay', 'happy', 'hangry'];

  //form values
  String _currentName;
  String _currentMood;
  int _currentHunger;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return StreamBuilder<UserData> (
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          UserData userData = snapshot.data;

          return Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          initialValue: userData.name,
                          decoration: textInputDecoration.copyWith(hintText: 'Name'),
                          validator: (val) => val.isEmpty ? 'Please enter a name' : null,
                          onChanged: (val) => setState(() => _currentName = val),
                        ),
                        SizedBox(height: 20.0),
                        DropdownButtonFormField(
                          decoration: textInputDecoration.copyWith(hintText: 'mood'),
                          value: _currentMood ?? userData.mood,
                          items: moods.map((mood){
                            return DropdownMenuItem(
                              value: mood,
                              child: Text('Feeling $mood'),
                            );
                          }).toList(),
                          onChanged: (val) => setState(() => _currentMood = val),
                        ),
                        SizedBox(height: 10.0),
                        Slider(
                          value: ( _currentHunger ?? userData.hunger).toDouble(),
                          activeColor: Colors.primaries[_currentHunger ?? userData.hunger],
                          inactiveColor: Colors.primaries[_currentHunger ?? userData.hunger],
                          min: 0.0,
                          max: 14.0,
                          divisions: 13,
                         onChanged: (val) => setState(() => _currentHunger = val.round()),
                        ),
                        SizedBox(height: 10.0),
                        RaisedButton(
                          color: Colors.pinkAccent,
                          child: Text(
                            'Update',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            if(_formKey.currentState.validate()){
                              await DatabaseService(uid: user.uid).updateUserData(
                                _currentName ?? userData.name, 
                                _currentMood ?? userData.mood,
                                _currentHunger ?? userData.hunger,
                                userData.favourites
                                );
                                Navigator.pop(context);
                            }
                          },
                        )

                      ]
                    )
                  );
        } else {
          return Loading();
        }
      },
    );
  }
}