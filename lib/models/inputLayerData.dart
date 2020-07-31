import 'package:imageshapecalculator/models/layerData.dart';
import 'package:imageshapecalculator/models/rectangle.dart';

class InputLayerData extends LayerData {
  Rectangle imageSize;
  int depth;

  InputLayerData({this.imageSize, this.depth});
}
