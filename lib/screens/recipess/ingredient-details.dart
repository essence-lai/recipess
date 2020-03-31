import 'package:flutter/material.dart';

class IngredientDetail extends StatefulWidget {
  final bool checked;
  final Map<String, dynamic> ingredient;
  IngredientDetail({ this.checked, this.ingredient });

  @override
  _IngredientDetailState createState() => _IngredientDetailState(checked: checked, ingredient: ingredient);
}

class _IngredientDetailState extends State<IngredientDetail> {
  bool checked;
  final Map<String, dynamic> ingredient;
  _IngredientDetailState({this.checked, this.ingredient});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric( vertical: 0.0, horizontal: 20.0),
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 14.0),
            child:  Align(
                child: Text('${ingredient['amount']} ${ingredient['unit']}', style: TextStyle(fontSize: 16.0),),
                alignment: Alignment.center,
              ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 20.0),
              child:  Text('${ingredient['ingredient']}', style: TextStyle(fontSize: 16.0),),
            ) ,
          ),
          Checkbox(
            checkColor: Colors.green[600],
            value: checked, 
            onChanged: (value){
              setState(() {
                checked = value;
              });
            },
          ),
        ],
      )
    );
  }
}