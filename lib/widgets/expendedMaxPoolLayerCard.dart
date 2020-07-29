import 'package:flutter/material.dart';
import 'package:imageshapecalculator/widgets/maxPoolLayer.dart';

import "layerCardExterior.dart";
import 'labeledVectorInputField.dart';

class ExpandedMaxPoolLayerCard extends StatelessWidget {
  const ExpandedMaxPoolLayerCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayerCardExterior(
      color: MaxPoolLayer.color,
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
                image: MaxPoolLayer.iconAssetImage,
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
