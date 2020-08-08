import 'package:flutter/material.dart';

class TwoLineText extends StatelessWidget {
  final String topText;
  final String bottomText;
  final TextStyle topTextStyle;
  final TextStyle bottomTextStyle;
  final CrossAxisAlignment crossAxisAlignment;

  const TwoLineText(
      {Key key,
      this.topText,
      this.bottomText,
      this.topTextStyle,
      this.bottomTextStyle,
      this.crossAxisAlignment})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: (this.crossAxisAlignment != null)
          ? this.crossAxisAlignment
          : CrossAxisAlignment.center,
      children: <Widget>[
        Text(this.topText, style: this.topTextStyle),
        Text(this.bottomText, style: this.bottomTextStyle)
      ],
    );
  }
}
