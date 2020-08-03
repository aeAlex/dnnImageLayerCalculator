import 'package:imageshapecalculator/models/ImageData.dart';
import 'package:imageshapecalculator/models/layerData.dart';
import 'package:imageshapecalculator/models/layers.dart';
import 'package:imageshapecalculator/widgets/convLayerCard.dart';
import 'package:imageshapecalculator/widgets/dismissableListViewItem.dart';
import 'package:imageshapecalculator/widgets/maxPoolLayerCard.dart';
import 'package:imageshapecalculator/widgets/toggleableInputLayer.dart';

void evaluateLayers(Layers layers) {
  print("evaluate");
  ToggleableInputLayer inputLayer = layers.layerList[0] as ToggleableInputLayer;
  ImageData imageData = inputLayer.inputLayerData;

  for (int i = 1; i < layers.layerList.length; i++) {
    DismissableListViewItem disLvItem =
        layers.layerList[i] as DismissableListViewItem;
    LayerData layerData = disLvItem.layerData;
    imageData = layerData.passTrough(imageData);
    print(
        "${imageData.imageSize.w}x${imageData.imageSize.h}x${imageData.depth}");
    if (disLvItem.child is ConvLayerCard) {
      ConvLayerCard convLayerCard = disLvItem.child as ConvLayerCard;
      convLayerCard.convLayerData.outputImageData = imageData;
      convLayerCard.key.currentState.update();
    }
    if (disLvItem.child is MaxPoolLayerCard) {
      MaxPoolLayerCard maxPoolLayerCard = disLvItem.child as MaxPoolLayerCard;
      maxPoolLayerCard.maxPoolLayerData.outputImageData = imageData;
      maxPoolLayerCard.key.currentState.update();
      print("Test");
    }
  }
}
