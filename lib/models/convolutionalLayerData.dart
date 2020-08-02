import 'package:imageshapecalculator/models/ImageData.dart';
import 'package:imageshapecalculator/models/layerData.dart';
import 'package:imageshapecalculator/models/rectangle.dart';

class ConvolutionalLayerData extends LayerData {
  int anzFilter;
  Rectangle kernel;
  Rectangle stride;
  int padding;
  ImageData outputImageData;

  ConvolutionalLayerData(
      {this.anzFilter, this.kernel, this.stride, this.padding = 0}) {
    outputImageData = ImageData(isDisplayed: false);
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
}
