import 'package:imageshapecalculator/models/ImageData.dart';
import 'package:imageshapecalculator/models/layerData.dart';
import 'package:imageshapecalculator/models/rectangle.dart';

class MaxPoolingLayerData extends LayerData {
  Rectangle kernel;
  Rectangle stride;

  MaxPoolingLayerData({this.kernel, this.stride});

  @override
  ImageData passTrough(ImageData imageData) {
    int width =
        ((imageData.imageSize.w - this.kernel.w) / this.stride.w).round() + 1;
    int height =
        ((imageData.imageSize.h - this.kernel.h) / this.stride.w).round() + 1;
    return ImageData(
        imageSize: Rectangle(w: width, h: height), depth: imageData.depth);
  }

  // TODO: Implement that the default values are the of the last same layer
}
