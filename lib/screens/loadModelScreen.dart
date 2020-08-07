import 'package:flutter/material.dart';
import 'package:imageshapecalculator/main.dart';
import 'package:imageshapecalculator/models/layerDB.dart';
import 'package:imageshapecalculator/widgets/layerCardExterior.dart';
import 'package:provider/provider.dart';

class LoadModelScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Widget> lvItems = <Widget>[ModelSelectionCard(), ModelSelectionCard()];

    ProviderData providerData = Provider.of<ProviderData>(context);
    LayerDB layerDB = providerData.layerDB;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(height: 20.0),
            Expanded(
              child: ListView(children: lvItems),
            ),
          ],
        ),
      ),
    );
  }
}

class ModelSelectionCard extends StatelessWidget {
  static const TextStyle bodyTextStyle =
      TextStyle(fontWeight: FontWeight.w400, fontSize: 16);

  const ModelSelectionCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayerCardExterior(
      color: Colors.orangeAccent,
      height: 65.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Layer Name:"),
                Text("BspLayerName", style: ModelSelectionCard.bodyTextStyle),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Creation Time:"),
                Text("BspCrationTime", style: ModelSelectionCard.bodyTextStyle),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
