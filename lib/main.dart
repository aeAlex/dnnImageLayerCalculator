import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:imageshapecalculator/screens/layerScreen.dart';
import 'package:provider/provider.dart';

import 'package:imageshapecalculator/models/layers.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Layers layers = Layers();
    return ChangeNotifierProvider(
      create: (BuildContext context) => layers,
      child: MaterialApp(home: LayerScreen()),
    );
  }
}
