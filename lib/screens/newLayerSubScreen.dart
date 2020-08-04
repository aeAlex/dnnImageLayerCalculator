import 'package:flutter/material.dart';
import 'package:imageshapecalculator/models/convolutionalLayerData.dart';
import 'package:imageshapecalculator/models/evaluateLayers.dart';
import 'package:imageshapecalculator/models/layerData.dart';
import 'package:imageshapecalculator/models/maxpoolingLayerData.dart';
import 'package:imageshapecalculator/models/rectangle.dart';
import 'package:imageshapecalculator/widgets/dismissableListViewItem.dart';
import 'package:imageshapecalculator/widgets/expendedConvLayerCard.dart';
import 'package:imageshapecalculator/widgets/expendedMaxPoolLayerCard.dart';

import 'package:provider/provider.dart';

import 'package:imageshapecalculator/widgets/convLayerCard.dart';
import 'package:imageshapecalculator/widgets/maxPoolLayerCard.dart';
import 'package:imageshapecalculator/models/layers.dart';

class NewLayerSubScreen extends StatelessWidget {
  static double subScreenHight = 262;
  final Function updateUiFunction;

  const NewLayerSubScreen({
    Key key,
    @required this.updateUiFunction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Layers layers = Provider.of<Layers>(context);

    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFDDDDDD),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
      ),
      height: NewLayerSubScreen.subScreenHight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          NewLayerSelectionCard(
            layerName: "Convolutional",
            color: ConvLayerCard.color,
            onSelected: () {
              print("Convolution-Layer was added");

              LayerData convLayerData = ConvolutionalLayerData(
                anzFilter: 64,
                kernel: Rectangle(w: 3, h: 3),
                stride: Rectangle(w: 1, h: 1),
              );

              GlobalKey<ConvLayerCardState> conLayerKey = GlobalKey();

              layers.layerList.add(
                DismissableListViewItem(
                  layerData: convLayerData,
                  child: ConvLayerCard(
                      convLayerData: convLayerData, key: conLayerKey),
                  expandedChild:
                      ExpandedConvLayerCard(convLayerData: convLayerData),
                  key: UniqueKey(),
                  onDismissed: (index) => layers.dismissElement(index),
                  onCopy: (index, item) => layers.copyElement(index, item),
                  index: layers.layerList.length,
                ),
              );
              this.updateUiFunction();
            },
          ),
          SizedBox(width: 8.0),
          NewLayerSelectionCard(
            layerName: "Maxpool",
            color: MaxPoolLayerCard.color,
            onSelected: () {
              print("Maxpool-Layer was added");

              LayerData maxPoolLayerData = MaxPoolingLayerData(
                  kernel: Rectangle(w: 2, h: 2), stride: Rectangle(w: 2, h: 2));

              GlobalKey<MaxPoolLayerCardState> maxPoolLayerKey = GlobalKey();

              layers.layerList.add(
                DismissableListViewItem(
                  layerData: maxPoolLayerData,
                  child: MaxPoolLayerCard(
                    maxPoolLayerData: maxPoolLayerData,
                    key: maxPoolLayerKey,
                  ),
                  expandedChild: ExpandedMaxPoolLayerCard(
                    maxPoolLayerData: maxPoolLayerData,
                  ),
                  key: UniqueKey(),
                  onDismissed: (index) => layers.dismissElement(index),
                  onCopy: (index, item) => layers.copyElement(index, item),
                  index: layers.layerList.length,
                ),
              );
              this.updateUiFunction();
            },
          ),
        ],
      ),
    );
  }
}

class NewLayerSelectionCard extends StatelessWidget {
  final String layerName;
  final Color color;
  final Function onSelected;

  const NewLayerSelectionCard({
    Key key,
    @required this.layerName,
    @required this.color,
    @required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Layers layers = Provider.of<Layers>(context);

    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          color: this.color,
        ),
        height: 150,
        width: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Text(this.layerName), Text("Layer")],
        ),
      ),
      onTap: () {
        onSelected();
        evaluateLayers(layers);
      },
    );
  }
}
