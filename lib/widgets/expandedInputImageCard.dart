import 'package:flutter/material.dart';
import 'package:imageshapecalculator/widgets/inputImageCard.dart';

import 'labeledInputField.dart';
import 'labeledVectorInputField.dart';
import "layerCardExterior.dart";

class ExpandedInputImageCard extends StatelessWidget {
  const ExpandedInputImageCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayerCardExterior(
      height: 137.0,
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
              SizedBox(width: 20.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(height: 8.0),
                    LabeledVectorInputField(
                      label: "Image Size: ",
                    ),
                    LabeledInputField(label: "Depth: "),
                  ],
                ),
              ),
              SizedBox(width: 20.0),
            ],
          ),
        ],
      ),
    );
  }
}
