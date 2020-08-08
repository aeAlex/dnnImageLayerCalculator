import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Container getDeleteIcon(
    MainAxisAlignment mainAxisAlignment, EdgeInsets edgeInsets, double size) {
  return Container(
    child: Row(
      mainAxisAlignment: mainAxisAlignment,
      children: <Widget>[
        FaIcon(
          FontAwesomeIcons.trash,
          size: size,
        ),
      ],
    ),
    padding: edgeInsets,
  );
}
