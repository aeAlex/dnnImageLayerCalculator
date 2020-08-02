import 'package:flutter/material.dart';
import 'package:imageshapecalculator/models/convolutionalLayerData.dart';

import "layerCardExterior.dart";
import 'outputImageDisplay.dart';
import 'twoLineText.dart';

class ConvLayerCard extends StatefulWidget {
  static Color color = Color.fromARGB(255, 230, 207, 255);
  static AssetImage iconAssetImage = AssetImage('images/filter.png');

  ConvolutionalLayerData convLayerData;

  final GlobalKey<ConvLayerCardState> key;

  ConvLayerCard({
    this.key,
    @required this.convLayerData,
  }) : super(key: key);

  @override
  ConvLayerCardState createState() => ConvLayerCardState();
}

class ConvLayerCardState extends State<ConvLayerCard> {
  double height;

  void update() {
    setState(() {
      if (this.widget.convLayerData.outputImageData.isDisplayed) {
        this.height = 118.0;
      } else {
        this.height = 81.0;
      }
    });
  }

  @override
  void initState() {
    super.initState();

    this.update();
  }

  @override
  Widget build(BuildContext context) {
    return LayerCardExterior(
      height: this.height,
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
                        textAbove: "Stride:",
                        textBeneath:
                            "${widget.convLayerData.stride.w}x${widget.convLayerData.stride.h}"),
                    TwoLineText(
                      textAbove: "Padding:",
                      textBeneath: "${widget.convLayerData.padding}",
                    ),
                  ],
                ),
              ),
            ],
          ),
          (this.widget.convLayerData.outputImageData.isDisplayed)
              ? OutputImageDisplay(this.widget.convLayerData.outputImageData,
                  color: Colors.deepPurpleAccent)
              : Container(),
        ],
      ),
    );
  }
}
