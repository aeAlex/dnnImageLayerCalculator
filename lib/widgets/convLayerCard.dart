import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:imageshapecalculator/models/convolutionalLayerData.dart';

import "layerCardExterior.dart";
import 'outputImageDisplay.dart';
import 'twoLineText.dart';

class ConvLayerCard extends StatefulWidget {
  static Color color = Color.fromARGB(255, 230, 207, 255);
  static FaIcon faIcon = FaIcon(
    FontAwesomeIcons.filter,
    size: 50,
  );

  ConvolutionalLayerData convLayerData;

  final GlobalKey<ConvLayerCardState> key;

  ConvLayerCard({
    @required this.key,
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
        this.height = 133.0;
      } else {
        this.height = 90.0;
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
              ConvLayerCard.faIcon,
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    TwoLineText(
                      topText: "Filter:",
                      bottomText: "${widget.convLayerData.anzFilter}",
                    ),
                    TwoLineText(
                        topText: "Kernel:",
                        bottomText:
                            "${widget.convLayerData.kernel.w}x${widget.convLayerData.kernel.h}"),
                    TwoLineText(
                        topText: "Stride:",
                        bottomText:
                            "${widget.convLayerData.stride.w}x${widget.convLayerData.stride.h}"),
                    TwoLineText(
                      topText: "Padding:",
                      bottomText: "${widget.convLayerData.padding}",
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
