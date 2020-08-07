import 'package:flutter/material.dart';
import 'package:imageshapecalculator/models/layerDB.dart';
import 'package:imageshapecalculator/models/layers.dart';

import '../constants.dart';

class LoadModelButton extends StatelessWidget {
  final Layers layers;
  final LayerDB layerDB;

  const LoadModelButton({@required this.layers, @required this.layerDB});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: LayerScreenBottomButtonBoxDecoration,
      margin: EdgeInsets.all(10.0),
      child: FlatButton(
        onPressed: () {
          print("Loading model");
        },
        child: Text(
          "Load Model",
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
