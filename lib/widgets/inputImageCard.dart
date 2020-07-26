import 'package:flutter/cupertino.dart';
import 'package:imageshapecalculator/widgets/layerCardExterior.dart';

import 'twoLineText.dart';

class InputImageCard extends StatelessWidget {
  const InputImageCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayerCardExterior(
      color: Color.fromARGB(255, 255, 237, 133),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Image-Input-Layer",
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          Row(
            children: <Widget>[
              SizedBox(width: 20.0),
              Image(
                image: AssetImage('images/enter.png'),
                width: 50.0,
                height: 50.0,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    TwoLineText(
                        textAbove: "Image Size:", textBeneath: "128x128"),
                    TwoLineText(textAbove: "Depth:", textBeneath: "3"),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
