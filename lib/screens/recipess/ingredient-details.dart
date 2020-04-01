import 'package:flutter/material.dart';

class IngredientDetail extends StatefulWidget {
  final bool checked;
  final Map<String, dynamic> ingredient;
  double fraction;
  IngredientDetail({ this.checked, this.ingredient, this.fraction });

  @override
  _IngredientDetailState createState() => _IngredientDetailState(checked: checked, ingredient: ingredient, fraction: fraction);
}

class _IngredientDetailState extends State<IngredientDetail> {
  bool checked;
  final Map<String, dynamic> ingredient;
  double fraction;
  _IngredientDetailState({ this.checked, this.ingredient, this.fraction });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: ( details){
        setState(() {
          checked = !checked;
        });
      },
      child: Padding(
      padding: EdgeInsets.symmetric( vertical: 0.0, horizontal: 20.0),
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 14.0),
            child:  Align(
                child: Text('${(ingredient['amount']*widget.fraction).round()} ${ingredient['unit']}', style: TextStyle(fontSize: 16.0,  decoration: checked ? TextDecoration.lineThrough: TextDecoration.none),),
                alignment: Alignment.center,
              ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 20.0),
              child:  Text('${ingredient['ingredient']}', style: TextStyle(fontSize: 16.0, decoration: checked ? TextDecoration.lineThrough: TextDecoration.none),),
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
     )
    );
  }
}