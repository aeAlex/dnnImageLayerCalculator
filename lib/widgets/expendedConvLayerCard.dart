import 'package:flutter/material.dart';

import "layerCardExterior.dart";
import 'twoLineText.dart';

class ExpandedConvLayerCard extends StatelessWidget {
  static Color color = Color.fromARGB(255, 230, 207, 255);

  const ExpandedConvLayerCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayerCardExterior(
      color: ExpandedConvLayerCard.color,
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
                image: AssetImage('images/filter.png'),
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
