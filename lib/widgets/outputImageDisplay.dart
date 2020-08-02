import 'package:flutter/material.dart';
import 'package:imageshapecalculator/models/ImageData.dart';

class OutputImageDisplay extends StatelessWidget {
  final ImageData outputImageData;
  final Color color;

  const OutputImageDisplay(
    this.outputImageData, {
    Key key,
    this.color = Colors.deepPurpleAccent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            child: Image(
              image: AssetImage('images/arrow.png'),
            ),
            height: 30.0,
          ),
          SizedBox(width: 10.0),
          Container(
            decoration: BoxDecoration(
              color: Colors.deepPurpleAccent,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            child: Text(
                "${this.outputImageData.imageSize.w}x${this.outputImageData.imageSize.h}x${this.outputImageData.depth}"),
            padding: EdgeInsets.all(10.0),
          ),
        ],
      ),
      key: UniqueKey(),
    );
  }
}
