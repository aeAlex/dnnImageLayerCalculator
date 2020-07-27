import 'package:flutter/material.dart';

import 'package:imageshapecalculator/widgets/convLayerCard.dart';
import 'package:imageshapecalculator/widgets/dismissableListViewItem.dart';
import 'package:imageshapecalculator/widgets/inputImageCard.dart';
import 'package:imageshapecalculator/widgets/maxPoolLayer.dart';
import 'package:imageshapecalculator/widgets/expendedConvLayerCard.dart';

class Layers extends ChangeNotifier {
  List<Widget> layerList;

  Layers() {
    this.layerList = <Widget>[
      InputImageCard(key: UniqueKey()),
      DismissableListViewItem(
        child: ConvLayerCard(),
        expandedChild: ExpandedConvLayerCard(),
        key: UniqueKey(),
        onDismissed: (index) => this.dismissElement(index),
        index: 1,
      ),
      DismissableListViewItem(
        child: MaxPoolLayer(),
        key: UniqueKey(),
        onDismissed: (index) => this.dismissElement(index),
        index: 2,
      ),
    ];
  }

  void updateElementIndices() {
    for (int i = 1; i < this.layerList.length; i++) {
      (this.layerList[i] as DismissableListViewItem).index = i;
    }
  }

  void dismissElement(int index) {
    this.layerList.removeAt(index);
    updateElementIndices();
  }

  void reorderElements(int oldIndex, int newIndex) {
    // abrechen wenn der Input layer verschiebt werden soll
    if (oldIndex == 0 || newIndex == 0) return;
    // wurde oberhalb der alten Position positioniert
    Widget oldElement = this.layerList.removeAt(oldIndex);
    if (newIndex < oldIndex) {
      this.layerList.insert(newIndex, oldElement);
    } else {
      this.layerList.insert(newIndex - 1, oldElement);
    }
    print("oldIndex: $oldIndex, newIndex: $newIndex");
    updateElementIndices();
  }
}
