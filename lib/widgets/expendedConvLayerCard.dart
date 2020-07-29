import 'package:flutter/material.dart';
import 'package:imageshapecalculator/widgets/convLayerCard.dart';

import 'labeledInputField.dart';
import 'labeledVectorInputField.dart';
import "layerCardExterior.dart";

class ExpandedConvLayerCard extends StatelessWidget {
  const ExpandedConvLayerCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayerCardExterior(
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
              SizedBox(width: 20.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(height: 8.0),
                    LabeledInputField(label: "Filter: "),
                    LabeledVectorInputField(
                      label: "Kernel:",
                    ),
                    LabeledVectorInputField(
                      label: "Shift: ",
                    ),
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
