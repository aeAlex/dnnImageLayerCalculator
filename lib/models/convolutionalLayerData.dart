import 'package:imageshapecalculator/models/layerData.dart';
import 'package:imageshapecalculator/models/rectangle.dart';

class ConvolutionalLayerData extends LayerData {
  int anzFilter;
  Rectangle kernel;
  Rectangle shift;

  ConvolutionalLayerData({this.anzFilter, this.kernel, this.shift});
}
