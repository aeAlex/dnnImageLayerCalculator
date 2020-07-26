import 'package:flutter/material.dart';
import 'package:imageshapecalculator/widgets/convLayerCard.dart';
import 'package:imageshapecalculator/widgets/maxPoolLayer.dart';

import 'dismissableListViewItem.dart';

class NewLayerSubScreen extends StatelessWidget {
  final List<Widget> layers;

  const NewLayerSubScreen({
    Key key,
    @required this.layers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              onClick: () {
                this.layers.add(
                      DismissableListViewItem(
                        child: ConvLayerCard(),
                        key: UniqueKey(),
                        onDismissed: (index) => this.dismissElement(index),
                        index: 1,
                      ),
                    );
              },
            ),
            SizedBox(width: 8.0),
            NewLayerSelectionCard(
              layerName: "Maxpool",
              color: MaxPoolLayer.color,
              onClick: () {},
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
  final Function onClick;

  const NewLayerSelectionCard({
    Key key,
    @required this.layerName,
    @required this.color,
    @required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: this.color,
      ),
      height: 150,
      width: 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[Text(this.layerName), Text("Layer")],
      ),
    );
  }
}
