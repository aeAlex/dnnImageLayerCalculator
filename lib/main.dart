import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'widgets/convLayerCard.dart';
import 'widgets/maxPoolLayer.dart';
import 'widgets/inputImageCard.dart';

void main() {
  runApp(MainScreen());
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(8.0),
                  children: <Widget>[
                    InputImageCard(),
                    ConvLayerCard(),
                    ConvLayerCard(),
                    MaxPoolLayer(),
                    ConvLayerCard(),
                    ConvLayerCard(),
                    MaxPoolLayer(),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    onPressed: () {
                      print("evaluate");
                    },
                    child: Text("evaluate"),
                  ),
                  NewLayerButton(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class NewLayerButton extends StatelessWidget {
  const NewLayerButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (context) => Container(
            decoration: BoxDecoration(color: Color(0xFF737373)),
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFDDDDDD),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0)),
              ),
              height: 262,
            ),
          ),
        );
      },
      child: Text("new Layer"),
    );
  }
}
