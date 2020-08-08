import 'package:flutter/material.dart';
import 'package:imageshapecalculator/screens/layerScreen.dart';
import 'package:imageshapecalculator/screens/loadModelScreen.dart';

import '../constants.dart';

class LoadModelButton extends StatelessWidget {
  final LayerScreenState parent;

  const LoadModelButton({@required this.parent});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: LayerScreenBottomButtonBoxDecoration,
      margin: EdgeInsets.all(10.0),
      child: FlatButton(
        onPressed: () {
          final savedModelData = Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return LoadModelScreen();
            }),
          );
          this.parent.layers.loadLayersFromSavedModelData(
              savedModelData, this.parent.layerDB);
        },
        child: Text(
          "Load Model",
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
