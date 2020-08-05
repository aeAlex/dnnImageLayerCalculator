import 'package:flutter/material.dart';

const LayerScreenBottomButtonBoxDecoration = BoxDecoration(
  color: Colors.blue,
  borderRadius: BorderRadius.all(Radius.circular(20.0)),
  boxShadow: [
    BoxShadow(
        color: Colors.black45,
        blurRadius: 2.0,
        spreadRadius: 2.0,
        offset: Offset(2.0, 2.0)),
  ],
);
