import 'package:imageshapecalculator/models/rectangle.dart';

class ImageData {
  Rectangle imageSize;
  int depth;
  bool isDisplayed;

  ImageData({this.imageSize, this.depth, this.isDisplayed = true});
}
