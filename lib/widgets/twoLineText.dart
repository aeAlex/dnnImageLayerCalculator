import 'package:flutter/material.dart';

class TwoLineText extends StatelessWidget {
  final String textAbove;
  final String textBeneath;

  const TwoLineText({Key key, this.textAbove, this.textBeneath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[Text(this.textAbove), Text(this.textBeneath)],
    );
  }
}
