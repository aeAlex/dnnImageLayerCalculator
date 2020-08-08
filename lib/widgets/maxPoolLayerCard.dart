import 'package:flutter/material.dart';
import 'package:imageshapecalculator/models/maxpoolingLayerData.dart';
import 'package:imageshapecalculator/widgets/layerCardExterior.dart';
import 'package:imageshapecalculator/widgets/outputImageDisplay.dart';

import 'twoLineText.dart';

class MaxPoolLayerCard extends StatefulWidget {
  static Color color = Color.fromARGB(255, 205, 231, 251);
  static AssetImage iconAssetImage = AssetImage('images/down.png');

  MaxPoolingLayerData maxPoolLayerData;

  final GlobalKey<MaxPoolLayerCardState> key;

  MaxPoolLayerCard({
    @required this.key,
    @required this.maxPoolLayerData,
  }) : super(key: key);

  @override
  MaxPoolLayerCardState createState() => MaxPoolLayerCardState();
}

class MaxPoolLayerCardState extends State<MaxPoolLayerCard> {
  double height;

  void update() {
    setState(() {
      if (this.widget.maxPoolLayerData.outputImageData.isDisplayed) {
        this.height = 128.0;
      } else {
        this.height = 91.0;
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
      color: MaxPoolLayerCard.color,
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
                image: MaxPoolLayerCard.iconAssetImage,
                width: 50.0,
                height: 50.0,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    TwoLineText(
                        topText: "Kernel:",
                        bottomText:
                            "${widget.maxPoolLayerData.kernel.w}x${widget.maxPoolLayerData.kernel.h}"),
                    TwoLineText(
                        topText: "Stride:",
                        bottomText:
                            "${widget.maxPoolLayerData.stride.w}x${widget.maxPoolLayerData.stride.h}"),
                  ],
                ),
              ),
            ],
          ),
          (this.widget.maxPoolLayerData.outputImageData.isDisplayed)
              ? OutputImageDisplay(this.widget.maxPoolLayerData.outputImageData,
                  color: Colors.deepPurpleAccent)
              : Container(),
        ],
      ),
    );
  }
}
