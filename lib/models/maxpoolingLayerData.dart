import 'package:imageshapecalculator/models/layerData.dart';
import 'package:imageshapecalculator/models/rectangle.dart';

class MaxPoolingLayerData extends LayerData {
  Rectangle kernel;
  Rectangle shift;

  MaxPoolingLayerData({this.kernel, this.shift});

  // TODO: Implement that the default values are the of the last same layer
}
