import 'package:flutter/material.dart';
import 'package:imageshapecalculator/models/convolutionalLayerData.dart';

import "layerCardExterior.dart";
import 'twoLineText.dart';

class ConvLayerCard extends StatelessWidget {
  static Color color = Color.fromARGB(255, 230, 207, 255);
  static AssetImage iconAssetImage = AssetImage('images/filter.png');

  final ConvolutionalLayerData convLayerData;

  const ConvLayerCard({
    Key key,
    @required this.convLayerData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayerCardExterior(
      height: 118,
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
                      textBeneath: "${convLayerData.anzFilter}",
                    ),
                    TwoLineText(
                        textAbove: "Kernel:",
                        textBeneath:
                            "${convLayerData.kernel.w}x${convLayerData.kernel.h}"),
                    TwoLineText(
                        textAbove: "Stride:",
                        textBeneath:
                            "${convLayerData.stride.w}x${convLayerData.stride.h}"),
                    TwoLineText(
                      textAbove: "Padding:",
                      textBeneath: "${convLayerData.padding}",
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  child: Image(
                    image: AssetImage('images/arrow.png'),
                  ),
                  height: 30.0,
                ),
                SizedBox(width: 10.0),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.deepPurpleAccent,
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  child: Text("08942x0434982x34243"),
                  padding: EdgeInsets.all(10.0),
                ),
              ],
            ),
            key: UniqueKey(),
          ),
        ],
      ),
    );
  }
}
