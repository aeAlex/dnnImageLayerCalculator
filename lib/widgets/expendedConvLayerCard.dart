import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import "layerCardExterior.dart";
import 'twoLineText.dart';

class ExpandedConvLayerCard extends StatelessWidget {
  static Color color = Color.fromARGB(255, 230, 207, 255);

  const ExpandedConvLayerCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayerCardExterior(
      color: ExpandedConvLayerCard.color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Convolutional-Layer",
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          Row(
            children: <Widget>[
              SizedBox(width: 20.0),
              Image(
                image: AssetImage('images/filter.png'),
                width: 50.0,
                height: 50.0,
              ),
              SizedBox(width: 20.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(height: 8.0),
                    LabeledInputField(label: "Filter: "),
                    LabeledVektorInputField(
                      label: "Kernel:",
                    ),
                    LabeledVektorInputField(
                      label: "Shift: ",
                    ),
                  ],
                ),
              ),
              SizedBox(width: 20.0),
            ],
          ),
        ],
      ),
    );
  }

  Container getShiftInputField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.pinkAccent[100],
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      child: Row(
        children: <Widget>[
          SizedBox(
              child: Text(
                "Shift: ",
                textAlign: TextAlign.end,
              ),
              width: 45.0),
          SizedBox(width: 10.0),
          Expanded(
              child: SizedBox(
            child: TextField(),
            height: 30.0,
          )),
          Text("x"),
          Expanded(
              child: SizedBox(
            child: TextField(),
            height: 30.0,
          )),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      margin: EdgeInsets.only(bottom: 8.0),
    );
  }
}

class LabeledInputField extends StatelessWidget {
  final String label;

  const LabeledInputField({
    Key key,
    @required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.pinkAccent[100],
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      child: Row(
        children: <Widget>[
          SizedBox(
              child: Text(
                this.label,
                textAlign: TextAlign.end,
              ),
              width: 45.0),
          SizedBox(width: 10.0),
          Expanded(
              child: SizedBox(
            child: TextField(
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                WhitelistingTextInputFormatter.digitsOnly
              ], // Only numbers can be entered
            ),
            height: 30.0,
          )),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      margin: EdgeInsets.only(bottom: 8.0),
    );
  }
}

class LabeledVektorInputField extends StatelessWidget {
  final String label;

  const LabeledVektorInputField({
    Key key,
    @required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.pinkAccent[100],
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      child: Row(
        children: <Widget>[
          SizedBox(
              child: Text(
                this.label,
                textAlign: TextAlign.end,
              ),
              width: 45.0),
          SizedBox(width: 10.0),
          Expanded(
              child: SizedBox(
            child: TextField(),
            height: 30.0,
          )),
          Text("x"),
          Expanded(
              child: SizedBox(
            child: TextField(),
            height: 30.0,
          )),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      margin: EdgeInsets.only(bottom: 8.0),
    );
  }
}
