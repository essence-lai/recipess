import 'package:flutter/material.dart';

class InstructionDetail extends StatefulWidget {
  final bool checked;
  final Map<String, dynamic> instruction;
  InstructionDetail({ this.checked, this.instruction });

  @override
  _InstructionDetailState createState() => _InstructionDetailState(checked: checked, instruction: instruction);
}

class _InstructionDetailState extends State<InstructionDetail> {
  bool checked;
  final Map<String, dynamic> instruction;
  _InstructionDetailState({ this.checked, this.instruction });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: GestureDetector(
        onHorizontalDragStart: ( details){
          setState(() {
            checked = !checked;
          });
        },
        child:    Padding(
        padding: EdgeInsets.fromLTRB(34, 16, 20, 4),
        child: Row(
          children: <Widget>[
            Expanded(child: 
             Center( child: Text('${ instruction['description']}',
                style: TextStyle(fontSize: 16.0, decoration: checked ? TextDecoration.lineThrough: TextDecoration.none),
                )
              ),
            ),
            Checkbox(
              activeColor: Colors.white,
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
      )
    );
  }
}