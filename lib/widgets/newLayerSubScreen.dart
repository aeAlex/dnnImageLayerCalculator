import 'package:flutter/material.dart';
import 'package:imageshapecalculator/widgets/expendedConvLayerCard.dart';
import 'package:imageshapecalculator/widgets/expendedMaxPoolLayerCard.dart';

import 'package:provider/provider.dart';

import 'package:imageshapecalculator/widgets/convLayerCard.dart';
import 'package:imageshapecalculator/widgets/maxPoolLayer.dart';
import 'package:imageshapecalculator/models/layers.dart';

import 'dismissableListViewItem.dart';

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
              layers.layerList.add(
                DismissableListViewItem(
                  child: ConvLayerCard(),
                  expandedChild: ExpandedConvLayerCard(),
                  key: UniqueKey(),
                  onDismissed: (index) => layers.dismissElement(index),
                  index: layers.layerList.length,
                ),
              );
              this.updateUiFunction();
            },
          ),
          SizedBox(width: 8.0),
          NewLayerSelectionCard(
            layerName: "Maxpool",
            color: MaxPoolLayer.color,
            onSelected: () {
              print("Maxpool-Layer was added");
              layers.layerList.add(
                DismissableListViewItem(
                  child: MaxPoolLayer(),
                  expandedChild: ExpandedMaxPoolLayerCard(),
                  key: UniqueKey(),
                  onDismissed: (index) => layers.dismissElement(index),
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
      onTap: onSelected,
    );
  }
}
