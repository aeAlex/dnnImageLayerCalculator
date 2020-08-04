import 'package:flutter/material.dart';
import 'package:imageshapecalculator/models/evaluateLayers.dart';
import 'package:imageshapecalculator/screens/newLayerSubScreen.dart';

import 'package:provider/provider.dart';

import 'package:imageshapecalculator/models/layers.dart';

class LayerScreen extends StatefulWidget {
  @override
  _LayerScreenState createState() => _LayerScreenState();
}

class _LayerScreenState extends State<LayerScreen> {
  ScrollController scrollController;
  bool isSubScreenShown = false;
  PersistentBottomSheetController bottomSheet;
  Layers layers;

  bool firstEvaluation = true;
  @override
  void initState() {
    super.initState();

    this.scrollController = ScrollController();

    WidgetsBinding.instance.addPersistentFrameCallback((timeStamp) {
      if (firstEvaluation) {
        firstEvaluation = false;
        evaluateLayers(layers);
      }
    });
  }

  void scrollToBottom() {
    setState(() {});
    double maxScrollPosition = this.scrollController.position.maxScrollExtent;
    print(maxScrollPosition);
    //this.scrollController.jumpTo(maxScrollPosition);
    this.scrollController.animateTo(maxScrollPosition,
        duration: Duration(microseconds: 2000), curve: Curves.decelerate);
  }

  setIsSubScreenShown(bool value) {
    setState(() {
      this.isSubScreenShown = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Geting the Layers from the Provider:
    layers = Provider.of<Layers>(context);

    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: GestureDetector(
            onTap: () {
              if (this.isSubScreenShown) bottomSheet.close();
            },
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
                    scrollController: this.scrollController,
                  ),
                ),
                (this.isSubScreenShown)
                    ? SizedBox(height: NewLayerSubScreen.subScreenHight)
                    : Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFDDDDDD),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            NewLayerButton(parrent: this),
                          ],
                        ),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NewLayerButton extends StatelessWidget {
  final _LayerScreenState parrent;

  const NewLayerButton({Key key, @required this.parrent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        boxShadow: [
          BoxShadow(
              color: Colors.black45,
              blurRadius: 2.0,
              spreadRadius: 2.0,
              offset: Offset(2.0, 2.0)),
        ],
      ),
      margin: EdgeInsets.all(10.0),
      child: FlatButton(
        onPressed: () {
          this.parrent.bottomSheet = showBottomSheet(
            context: context,
            builder: (context) => NewLayerSubScreen(
                updateUiFunction: this.parrent.scrollToBottom),
          );
          this.parrent.setIsSubScreenShown(true);
          this
              .parrent
              .bottomSheet
              .closed
              .then((value) => this.parrent.setIsSubScreenShown(false));
        },
        child: Text(
          "new Layer",
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
