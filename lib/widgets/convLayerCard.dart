import 'package:flutter/material.dart';

import "layerCardExterior.dart";
import 'twoLineText.dart';

class ConvLayerCard extends StatelessWidget {
  static Color color = Color.fromARGB(255, 230, 207, 255);
  static AssetImage iconAssetImage = AssetImage('images/filter.png');

  const ConvLayerCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayerCardExterior(
      height: 81,
      color: ConvLayerCard.color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Convolutional-Layer",
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          Row(
            children: <Widget>[
              SizedBox(width: 20.0),
              Image(
                image: ConvLayerCard.iconAssetImage,
                width: 50.0,
                height: 50.0,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    TwoLineText(textAbove: "Filter:", textBeneath: "32"),
                    TwoLineText(textAbove: "Kernel:", textBeneath: "3x3"),
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
