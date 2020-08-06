import 'package:flutter/material.dart';
import 'package:imageshapecalculator/models/ImageData.dart';
import 'package:imageshapecalculator/models/layerDB.dart';
import 'package:imageshapecalculator/models/layerData.dart';
import 'package:imageshapecalculator/models/layers.dart';
import 'package:imageshapecalculator/models/rectangle.dart';
import 'package:imageshapecalculator/widgets/convLayerCard.dart';
import 'package:imageshapecalculator/widgets/dismissableListViewItem.dart';
import 'package:imageshapecalculator/widgets/expendedConvLayerCard.dart';

class ConvolutionalLayerData extends LayerData {
  int anzFilter;
  Rectangle kernel;
  Rectangle stride;
  int padding;

  ConvolutionalLayerData(
      {this.anzFilter, this.kernel, this.stride, this.padding = 0}) {
    outputImageData = ImageData(isDisplayed: false);
    this.layerType = LayerType.ConvolutionalLayer;
  }

  @override
  ImageData passTrough(ImageData imageData) {
    //"${imageData.imageSize.w}-${this.kernel.w}+2*${this.padding}/${this.stride.w}");
    int width = ((imageData.imageSize.w - this.kernel.w + 2 * this.padding) /
                this.stride.w)
            .round() +
        1;
    int height = ((imageData.imageSize.h - this.kernel.h + 2 * this.padding) /
                this.stride.h)
            .round() +
        1;
    return ImageData(
        imageSize: Rectangle(w: width, h: height), depth: this.anzFilter);
  }

  @override
  LayerData copyLayerData() {
    return ConvolutionalLayerData(
      anzFilter: this.anzFilter,
      kernel: Rectangle(w: this.kernel.w, h: this.kernel.h),
      stride: Rectangle(w: this.stride.w, h: this.stride.h),
      padding: this.padding,
    );
  }

  @override
  DismissableListViewItem copyLayer(Layers layers) {
    ConvolutionalLayerData convLayerData = this.copyLayerData();
    GlobalKey<ConvLayerCardState> conLayerKey = GlobalKey();

    return DismissableListViewItem(
      layerData: convLayerData,
      child: ConvLayerCard(key: conLayerKey, convLayerData: convLayerData),
      expandedChild: ExpandedConvLayerCard(convLayerData: convLayerData),
      key: UniqueKey(),
      onDismissed: (index) => layers.dismissElement(index),
      onCopy: (index, item) => layers.copyElement(index, item),
      index: 1,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'anzFilter': this.anzFilter,
      'padding': this.padding,
      'stride': this.stride,
      'kernel': this.kernel
    };
  }
}
