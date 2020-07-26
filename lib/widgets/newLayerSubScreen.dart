import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:imageshapecalculator/widgets/convLayerCard.dart';
import 'package:imageshapecalculator/widgets/maxPoolLayer.dart';
import 'package:imageshapecalculator/models/layers.dart';

import 'dismissableListViewItem.dart';

class NewLayerSubScreen extends StatelessWidget {
  const NewLayerSubScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Layers layers = Provider.of<Layers>(context);

    return Container(
      decoration: BoxDecoration(color: Color(0xFF737373)),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFDDDDDD),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40.0), topRight: Radius.circular(40.0)),
        ),
        height: 262,
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
                    key: UniqueKey(),
                    onDismissed: (index) => layers.dismissElement(index),
                    index: 1,
                  ),
                );
              },
            ),
            SizedBox(width: 8.0),
            NewLayerSelectionCard(
              layerName: "Maxpool",
              color: MaxPoolLayer.color,
              onSelected: () {
                print("Maxpool-Layer was added");
              },
            ),
          ],
        ),
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
