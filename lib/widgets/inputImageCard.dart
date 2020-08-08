import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:imageshapecalculator/models/ImageData.dart';
import 'package:imageshapecalculator/widgets/layerCardExterior.dart';

import 'twoLineText.dart';

class InputImageCard extends StatelessWidget {
  static Color color = Color.fromARGB(255, 255, 237, 133);
  static FaIcon faIcon = FaIcon(
    FontAwesomeIcons.images,
    size: 50,
  );

  final ImageData inputLayerData;

  const InputImageCard({
    Key key,
    @required this.inputLayerData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayerCardExterior(
      height: 101.0,
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
              InputImageCard.faIcon,
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    TwoLineText(
                        topText: "Image Size:",
                        bottomText:
                            "${this.inputLayerData.imageSize.w}x${this.inputLayerData.imageSize.h}"),
                    TwoLineText(
                        topText: "Depth:",
                        bottomText: "${this.inputLayerData.depth}"),
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
