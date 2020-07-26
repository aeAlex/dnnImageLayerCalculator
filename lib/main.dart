import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'widgets/convLayerCard.dart';
import 'widgets/maxPoolLayer.dart';
import 'widgets/inputImageCard.dart';

void main() {
  runApp(MainScreen());
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> listElements;

  @override
  void initState() {
    super.initState();

    this.listElements = <Widget>[
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
    for (int i = 1; i < this.listElements.length; i++) {
      (this.listElements[i] as DismissableListViewItem).index = i;
    }
  }

  void dismissElement(int index) {
    this.listElements.removeAt(index);
    updateElementIndices();
  }

  void reorderElements(int oldIndex, int newIndex) {
    // abrechen wenn der Input layer verschiebt werden soll
    if (oldIndex == 0 || newIndex == 0) return;
    // wurde oberhalb der alten Position positioniert
    Widget oldElement = this.listElements.removeAt(oldIndex);
    if (newIndex < oldIndex) {
      this.listElements.insert(newIndex, oldElement);
    } else {
      this.listElements.insert(newIndex - 1, oldElement);
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
                  children: this.listElements,
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
                        print(this.listElements.length);
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

class DismissableListViewItem extends StatefulWidget {
  final Widget child;
  final Function onDismissed;
  int index;
  DismissableListViewItem({
    Key key,
    @required this.child,
    @required this.onDismissed,
    @required this.index,
  }) : super(key: key);

  @override
  _DismissableListViewItemState createState() =>
      _DismissableListViewItemState();
}

class _DismissableListViewItemState extends State<DismissableListViewItem> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      child: widget.child,
      background: Container(color: Colors.lightGreenAccent),
      key: UniqueKey(),
      onDismissed: (direction) => this.widget.onDismissed(this.widget.index),
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
