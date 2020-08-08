import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:imageshapecalculator/screens/layerScreen.dart';
import 'package:provider/provider.dart';

import 'package:imageshapecalculator/models/layers.dart';

import 'models/layerDB.dart';

void main() {
  runApp(MyApp());
}

class ProviderData extends ChangeNotifier {
  Layers layers;
  LayerDB layerDB;

  ProviderData() {
    layers = Layers();
    layerDB = LayerDB();
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => ProviderData(),
      child: MaterialApp(
        home: LayerScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
