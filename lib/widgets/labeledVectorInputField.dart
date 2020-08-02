import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LabeledVectorInputField extends StatefulWidget {
  final String label;
  final String leftInitialValue;
  final String rightInitialValue;
  final Function onLeftChanged;
  final Function onRightChanged;

  const LabeledVectorInputField({
    Key key,
    @required this.label,
    @required this.leftInitialValue,
    @required this.rightInitialValue,
    @required this.onLeftChanged,
    @required this.onRightChanged,
  }) : super(key: key);

  @override
  _LabeledVectorInputFieldState createState() =>
      _LabeledVectorInputFieldState();
}

class _LabeledVectorInputFieldState extends State<LabeledVectorInputField> {
  final TextEditingController _leftInputFieldController =
      TextEditingController();
  final TextEditingController _rightInputFieldController =
      TextEditingController();
  String leftValue;
  String rightValue;

  @override
  void initState() {
    super.initState();

    this.leftValue = this.widget.leftInitialValue;
    this.rightValue = this.widget.rightInitialValue;

    this._leftInputFieldController.text = this.leftValue;
    this._rightInputFieldController.text = this.rightValue;
  }

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
                this.widget.label,
                textAlign: TextAlign.end,
              ),
              width: 55.0),
          SizedBox(width: 10.0),
          Expanded(
              child: SizedBox(
            child: TextField(
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                WhitelistingTextInputFormatter.digitsOnly
              ], // Only numbers can be entered
              textAlign: TextAlign.center,
              controller: this._leftInputFieldController,
              onChanged: (value) {
                this.leftValue = value;
                this.widget.onLeftChanged(value);
              },
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
              controller: this._rightInputFieldController,
              onChanged: (value) {
                this.rightValue = value;
                this.widget.onRightChanged(value);
              },
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
