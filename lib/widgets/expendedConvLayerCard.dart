import 'package:flutter/material.dart';
import 'package:imageshapecalculator/models/convolutionalLayerData.dart';
import 'package:imageshapecalculator/widgets/convLayerCard.dart';

import 'labeledInputField.dart';
import 'labeledVectorInputField.dart';
import "layerCardExterior.dart";

class ExpandedConvLayerCard extends StatelessWidget {
  final ConvolutionalLayerData convLayerData;

  const ExpandedConvLayerCard({
    Key key,
    @required this.convLayerData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayerCardExterior(
      height: 183.0,
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
                    LabeledInputField(
                      label: "Filter: ",
                      initialValue: this.convLayerData.anzFilter.toString(),
                      onChanged: (value) {
                        this.convLayerData.anzFilter = int.parse(value);
                      },
                    ),
                    LabeledVectorInputField(
                      label: "Kernel:",
                      leftInitialValue: this.convLayerData.kernel.w.toString(),
                      rightInitialValue: this.convLayerData.kernel.h.toString(),
                      onLeftChanged: (value) {
                        this.convLayerData.kernel.w = int.parse(value);
                      },
                      onRightChanged: (value) {
                        this.convLayerData.kernel.h = int.parse(value);
                      },
                    ),
                    LabeledVectorInputField(
                      label: "Shift: ",
                      leftInitialValue: this.convLayerData.shift.w.toString(),
                      rightInitialValue: this.convLayerData.shift.h.toString(),
                      onLeftChanged: (value) {
                        this.convLayerData.shift.w = int.parse(value);
                      },
                      onRightChanged: (value) {
                        this.convLayerData.shift.h = int.parse(value);
                      },
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
