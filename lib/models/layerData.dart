import 'package:imageshapecalculator/models/ImageData.dart';

abstract class LayerData {
  ImageData outputImageData;

  ImageData passTrough(ImageData imageData);
}
