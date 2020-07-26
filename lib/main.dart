import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'widgets/convLayerCard.dart';
import 'widgets/maxPoolLayer.dart';
import 'widgets/inputImageCard.dart';
import 'widgets/newLayerSubScreen.dart';
import 'widgets/dismissableListViewItem.dart';

void main() {
  runApp(MainScreen());
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> layers;

  @override
  void initState() {
    super.initState();

    this.layers = <Widget>[
      InputImageCard(key: UniqueKey()),
      DismissableListViewItem(
        child: ConvLayerCard(),
        key: UniqueKey(),
        onDismissed: (index) => this.dismissElement(index),
        index: 1,
      ),
      DismissableListViewItem(
        child: MaxPoolLayer(),
        key: UniqueKey(),
        onDismissed: (index) => this.dismissElement(index),
        index: 2,
      ),
    ];
  }

  void updateElementIndices() {
    for (int i = 1; i < this.layers.length; i++) {
      (this.layers[i] as DismissableListViewItem).index = i;
    }
  }

  void dismissElement(int index) {
    this.layers.removeAt(index);
    updateElementIndices();
  }

  void reorderElements(int oldIndex, int newIndex) {
    // abrechen wenn der Input layer verschiebt werden soll
    if (oldIndex == 0 || newIndex == 0) return;
    // wurde oberhalb der alten Position positioniert
    Widget oldElement = this.layers.removeAt(oldIndex);
    if (newIndex < oldIndex) {
      this.layers.insert(newIndex, oldElement);
    } else {
      this.layers.insert(newIndex - 1, oldElement);
    }
    print("oldIndex: $oldIndex, newIndex: $newIndex");
    updateElementIndices();
  }

  @override
  Widget build(BuildContext context) {
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
                      this.reorderElements(oldIndex, newIndex);
                    });
                  },
                  children: this.layers,
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
                        print(this.layers.length);
                      },
                      child: Text("evaluate"),
                    ),
                    NewLayerButton(layers: this.layers),
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
  final List<Widget> layers;

  const NewLayerButton({
    Key key,
    @required this.layers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (context) => NewLayerSubScreen(layers: this.layers),
        );
      },
      child: Text("new Layer"),
    );
  }
}
