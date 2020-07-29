import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LabeledVectorInputField extends StatelessWidget {
  final String label;

  const LabeledVectorInputField({
    Key key,
    @required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.pinkAccent[100],
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      child: Row(
        children: <Widget>[
          SizedBox(
              child: Text(
                this.label,
                textAlign: TextAlign.end,
              ),
              width: 45.0),
          SizedBox(width: 10.0),
          Expanded(
              child: SizedBox(
            child: TextField(
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                WhitelistingTextInputFormatter.digitsOnly
              ], // Only numbers can be entered
              textAlign: TextAlign.center,
            ),
            height: 30.0,
          )),
          Text("x"),
          Expanded(
              child: SizedBox(
            child: TextField(
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                WhitelistingTextInputFormatter.digitsOnly
              ], // Only numbers can be entered
              textAlign: TextAlign.center,
            ),
            height: 30.0,
          )),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      margin: EdgeInsets.only(bottom: 8.0),
    );
  }
}
