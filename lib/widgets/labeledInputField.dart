import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LabeledInputField extends StatefulWidget {
  final String label;
  final String initialValue;
  final Function onChanged;

  const LabeledInputField({
    Key key,
    @required this.label,
    this.initialValue,
    @required this.onChanged,
  }) : super(key: key);

  @override
  _LabeledInputFieldState createState() => _LabeledInputFieldState();
}

class _LabeledInputFieldState extends State<LabeledInputField> {
  final TextEditingController _inputFieldController = TextEditingController();
  String value;

  @override
  void initState() {
    super.initState();
    this.value = this.widget.initialValue;
    this._inputFieldController.text = this.value;
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
                controller: _inputFieldController,
                onChanged: (value) {
                  this.value = value;
                  this.widget.onChanged(value);
                },
              ),
              height: 30.0,
            ),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      margin: EdgeInsets.only(bottom: 8.0),
    );
  }
}
