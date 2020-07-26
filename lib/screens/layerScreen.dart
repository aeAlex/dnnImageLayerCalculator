import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:imageshapecalculator/widgets/newLayerSubScreen.dart';
import 'package:imageshapecalculator/models/layers.dart';

class LayerScreen extends StatefulWidget {
  @override
  _LayerScreenState createState() => _LayerScreenState();
}

class _LayerScreenState extends State<LayerScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Geting the Layers from the Provider:
    Layers layers = Provider.of<Layers>(context);

    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: ReorderableListView(
                  padding: const EdgeInsets.all(8.0),
                  onReorder: (int oldIndex, int newIndex) {
                    setState(() {
                      layers.reorderElements(oldIndex, newIndex);
                    });
                  },
                  children: layers.layerList,
                ),
              ),
              Container(
                decoration: BoxDecoration(color: Colors.blue),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () {
                        print("evaluate");
                        print(layers.layerList.length);
                      },
                      child: Text("evaluate"),
                    ),
                    NewLayerButton(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class NewLayerButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (context) => NewLayerSubScreen(),
        );
      },
      child: Text("new Layer"),
    );
  }
}
