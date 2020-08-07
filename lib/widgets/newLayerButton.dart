import 'package:flutter/material.dart';
import 'package:imageshapecalculator/screens/layerScreen.dart';
import 'package:imageshapecalculator/screens/newLayerSubScreen.dart';

import '../constants.dart';

class NewLayerButton extends StatelessWidget {
  final LayerScreenState parent;

  const NewLayerButton({Key key, @required this.parent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: LayerScreenBottomButtonBoxDecoration,
      margin: EdgeInsets.all(10.0),
      child: FlatButton(
        onPressed: () {
          this.parent.bottomSheet = showBottomSheet(
            context: context,
            builder: (context) =>
                NewLayerSubScreen(updateUiFunction: this.parent.scrollToBottom),
          );
          this.parent.setIsSubScreenShown(true);
          this
              .parent
              .bottomSheet
              .closed
              .then((value) => this.parent.setIsSubScreenShown(false));
        },
        child: Text(
          "new Layer",
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
