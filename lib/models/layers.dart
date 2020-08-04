import 'package:flutter/material.dart';
import 'package:imageshapecalculator/models/ImageData.dart';
import 'package:imageshapecalculator/models/evaluateLayers.dart';
import 'package:imageshapecalculator/models/layerData.dart';
import 'package:imageshapecalculator/models/maxpoolingLayerData.dart';
import 'package:imageshapecalculator/models/rectangle.dart';
import 'package:imageshapecalculator/widgets/convLayerCard.dart';
import 'package:imageshapecalculator/widgets/dismissableListViewItem.dart';
import 'package:imageshapecalculator/widgets/expendedMaxPoolLayerCard.dart';
import 'package:imageshapecalculator/widgets/maxPoolLayerCard.dart';
import 'package:imageshapecalculator/widgets/expendedConvLayerCard.dart';
import 'package:imageshapecalculator/widgets/toggleableInputLayer.dart';

import 'convolutionalLayerData.dart';

class Layers extends ChangeNotifier {
  List<Widget> layerList;
  Function updateUiFunction;

  LayerData convLayerData = ConvolutionalLayerData(
      anzFilter: 64,
      kernel: Rectangle(w: 3, h: 3),
      stride: Rectangle(w: 1, h: 1),
      padding: 0);

  LayerData maxPoolLayerData = MaxPoolingLayerData(
      kernel: Rectangle(w: 2, h: 2), stride: Rectangle(w: 2, h: 2));

  ImageData inputLayerData =
      ImageData(imageSize: Rectangle(w: 128, h: 128), depth: 3);

  GlobalKey<ConvLayerCardState> conLayerKey = GlobalKey();
  GlobalKey<MaxPoolLayerCardState> maxPoolLayerKey = GlobalKey();

  Layers() {
    this.layerList = <Widget>[
      ToggleableInputLayer(key: UniqueKey(), inputLayerData: inputLayerData),
      DismissableListViewItem(
        layerData: convLayerData,
        child: ConvLayerCard(key: conLayerKey, convLayerData: convLayerData),
        expandedChild: ExpandedConvLayerCard(convLayerData: convLayerData),
        key: UniqueKey(),
        onDismissed: (index) => this.dismissElement(index),
        onCopy: (index, item) => this.copyElement(index, item),
        index: 1,
      ),
      DismissableListViewItem(
        layerData: maxPoolLayerData,
        child: MaxPoolLayerCard(
          maxPoolLayerData: maxPoolLayerData,
          key: maxPoolLayerKey,
        ),
        expandedChild:
            ExpandedMaxPoolLayerCard(maxPoolLayerData: maxPoolLayerData),
        key: UniqueKey(),
        onDismissed: (index) => this.dismissElement(index),
        onCopy: (index, item) => this.copyElement(index, item),
        index: 2,
      ),
    ];
  }

  void setUpdateUiFunction(Function updateUiFunction) {
    this.updateUiFunction = updateUiFunction;
  }

  void updateElementIndices() {
    for (int i = 1; i < this.layerList.length; i++) {
      (this.layerList[i] as DismissableListViewItem).index = i;
    }
  }

  void dismissElement(int index) {
    this.layerList.removeAt(index);
    updateElementIndices();
    evaluateLayers(this);
  }

  void copyElement(index, DismissableListViewItem item) {
    // copy the Element:
    print("Copying Layer");
    DismissableListViewItem newItem = item.layerData.copyLayer(this);
    this.layerList.insert(index + 1, newItem);
    updateElementIndices();
    if (this.updateUiFunction == null) print("Update UI Function was null");
    evaluateLayers(this);
    this.updateUiFunction?.call();
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
    // update the evaluation of the Layers
    evaluateLayers(this);
  }
}
