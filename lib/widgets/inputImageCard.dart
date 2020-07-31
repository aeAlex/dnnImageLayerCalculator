import 'package:flutter/cupertino.dart';
import 'package:imageshapecalculator/models/inputLayerData.dart';
import 'package:imageshapecalculator/widgets/layerCardExterior.dart';

import 'twoLineText.dart';

class InputImageCard extends StatelessWidget {
  static Color color = Color.fromARGB(255, 255, 237, 133);
  static AssetImage iconAssetImage = AssetImage('images/enter.png');

  final InputLayerData inputLayerData;

  const InputImageCard({
    Key key,
    @required this.inputLayerData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayerCardExterior(
      height: 81.0,
      color: InputImageCard.color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Image-Input-Layer",
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          Row(
            children: <Widget>[
              SizedBox(width: 20.0),
              Image(
                image: InputImageCard.iconAssetImage,
                width: 50.0,
                height: 50.0,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    TwoLineText(
                        textAbove: "Image Size:",
                        textBeneath:
                            "${this.inputLayerData.imageSize.w}x${this.inputLayerData.imageSize.h}"),
                    TwoLineText(
                        textAbove: "Depth:",
                        textBeneath: "${this.inputLayerData.depth}"),
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
