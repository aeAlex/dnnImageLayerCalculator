import 'package:flutter/material.dart';
import 'package:imageshapecalculator/widgets/layerCardExterior.dart';

import 'twoLineText.dart';

class MaxPoolLayer extends StatelessWidget {
  static Color color = Color.fromARGB(255, 205, 231, 251);
  static AssetImage iconAssetImage = AssetImage('images/down.png');

  const MaxPoolLayer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayerCardExterior(
      color: MaxPoolLayer.color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Max-Pool-Layer",
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          Row(
            children: <Widget>[
              SizedBox(width: 20.0),
              Image(
                image: MaxPoolLayer.iconAssetImage,
                width: 50.0,
                height: 50.0,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    TwoLineText(textAbove: "Kernel:", textBeneath: "2x2"),
                    TwoLineText(textAbove: "Shift:", textBeneath: "1x1"),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
