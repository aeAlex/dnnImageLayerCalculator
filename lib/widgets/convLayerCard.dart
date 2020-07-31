import 'package:flutter/material.dart';
import 'package:imageshapecalculator/models/convolutionalLayerData.dart';

import "layerCardExterior.dart";
import 'twoLineText.dart';

class ConvLayerCard extends StatefulWidget {
  static Color color = Color.fromARGB(255, 230, 207, 255);
  static AssetImage iconAssetImage = AssetImage('images/filter.png');

  final ConvolutionalLayerData convLayerData;

  const ConvLayerCard({
    Key key,
    @required this.convLayerData,
  }) : super(key: key);

  @override
  _ConvLayerCardState createState() => _ConvLayerCardState();
}

class _ConvLayerCardState extends State<ConvLayerCard> {
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
                    TwoLineText(
                      textAbove: "Filter:",
                      textBeneath: "${widget.convLayerData.anzFilter}",
                    ),
                    TwoLineText(
                        textAbove: "Kernel:",
                        textBeneath:
                            "${widget.convLayerData.kernel.w}x${widget.convLayerData.kernel.h}"),
                    TwoLineText(
                        textAbove: "Shift:",
                        textBeneath:
                            "${widget.convLayerData.shift.w}x${widget.convLayerData.shift.h}"),
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
