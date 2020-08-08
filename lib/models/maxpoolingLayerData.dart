import 'package:flutter/material.dart';
import 'package:imageshapecalculator/models/ImageData.dart';
import 'package:imageshapecalculator/models/layerDB.dart';
import 'package:imageshapecalculator/models/layerData.dart';
import 'package:imageshapecalculator/models/layers.dart';
import 'package:imageshapecalculator/models/rectangle.dart';
import 'package:imageshapecalculator/widgets/dismissableListViewItem.dart';
import 'package:imageshapecalculator/widgets/expendedMaxPoolLayerCard.dart';
import 'package:imageshapecalculator/widgets/maxPoolLayerCard.dart';

class MaxPoolingLayerData extends LayerData {
  Rectangle kernel;
  Rectangle stride;

  MaxPoolingLayerData({this.kernel, this.stride}) {
    outputImageData = ImageData(isDisplayed: false);
    this.layerType = LayerType.MaxPoolLayer;
  }

  @override
  ImageData passTrough(ImageData imageData) {
    int width =
        ((imageData.imageSize.w - this.kernel.w) / this.stride.w).round() + 1;
    int height =
        ((imageData.imageSize.h - this.kernel.h) / this.stride.w).round() + 1;
    return ImageData(
        imageSize: Rectangle(w: width, h: height), depth: imageData.depth);
  }

  @override
  LayerData copyLayerData() {
    return MaxPoolingLayerData(
      kernel: Rectangle(w: this.kernel.w, h: this.kernel.h),
      stride: Rectangle(w: this.stride.w, h: this.stride.h),
    );
  }

  @override
  DismissableListViewItem copyLayer(Layers layers) {
    MaxPoolingLayerData maxPoolLayerData = this.copyLayerData();
    GlobalKey<MaxPoolLayerCardState> maxPoolLayerKey = GlobalKey();

    return DismissableListViewItem(
      layerData: maxPoolLayerData,
      child: MaxPoolLayerCard(
          key: maxPoolLayerKey, maxPoolLayerData: maxPoolLayerData),
      expandedChild:
          ExpandedMaxPoolLayerCard(maxPoolLayerData: maxPoolLayerData),
      key: UniqueKey(),
      onDismissed: (index) => layers.dismissElement(index),
      onCopy: (index, item) => layers.copyElement(index, item),
      index: 1,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {'kernel': this.kernel, 'stride': this.stride};
  }
}
