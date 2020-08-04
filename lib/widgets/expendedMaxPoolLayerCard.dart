import 'package:flutter/material.dart';
import 'package:imageshapecalculator/models/maxpoolingLayerData.dart';
import 'package:imageshapecalculator/widgets/maxPoolLayerCard.dart';

import "layerCardExterior.dart";
import 'labeledVectorInputField.dart';

class ExpandedMaxPoolLayerCard extends StatelessWidget {
  final MaxPoolingLayerData maxPoolLayerData;

  const ExpandedMaxPoolLayerCard({
    Key key,
    @required this.maxPoolLayerData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayerCardExterior(
      height: 145.0,
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
              SizedBox(width: 20.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(height: 8.0),
                    LabeledVectorInputField(
                      label: "Kernel:",
                      leftInitialValue:
                          this.maxPoolLayerData.kernel.w.toString(),
                      rightInitialValue:
                          this.maxPoolLayerData.kernel.h.toString(),
                      onLeftChanged: (value) {
                        this.maxPoolLayerData.kernel.w = int.parse(value);
                      },
                      onRightChanged: (value) {
                        this.maxPoolLayerData.kernel.h = int.parse(value);
                      },
                    ),
                    LabeledVectorInputField(
                      label: "Stride: ",
                      leftInitialValue:
                          this.maxPoolLayerData.stride.w.toString(),
                      rightInitialValue:
                          this.maxPoolLayerData.stride.h.toString(),
                      onLeftChanged: (value) {
                        this.maxPoolLayerData.stride.w = int.parse(value);
                      },
                      onRightChanged: (value) {
                        this.maxPoolLayerData.stride.h = int.parse(value);
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
