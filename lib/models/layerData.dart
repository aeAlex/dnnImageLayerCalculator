import 'package:imageshapecalculator/models/ImageData.dart';
import 'package:imageshapecalculator/models/layerDB.dart';
import 'package:imageshapecalculator/models/layers.dart';
import 'package:imageshapecalculator/widgets/dismissableListViewItem.dart';

abstract class LayerData {
  ImageData outputImageData;
  LayerType layerType;

  ImageData passTrough(ImageData imageData);
  DismissableListViewItem copyLayer(Layers layers);
  LayerData copyLayerData();
  Map<String, dynamic> toMap();
}
