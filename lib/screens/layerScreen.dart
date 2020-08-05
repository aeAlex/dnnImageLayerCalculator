import 'package:flutter/material.dart';
import 'package:imageshapecalculator/constants.dart';
import 'package:imageshapecalculator/models/evaluateLayers.dart';
import 'package:imageshapecalculator/models/saveModel.dart';
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

  updateUi() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // Geting the Layers from the Provider:
    layers = Provider.of<Layers>(context);
    layers.setUpdateUiFunction(updateUi);

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
                  child: Theme(
                    data: ThemeData(canvasColor: Colors.transparent),
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
                            SaveModelsButton(parent: this),
                            NewLayerButton(parent: this),
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

class SaveModelsButton extends StatefulWidget {
  final _LayerScreenState parent;

  const SaveModelsButton({
    Key key,
    @required this.parent,
  }) : super(key: key);

  @override
  _SaveModelsButtonState createState() => _SaveModelsButtonState();
}

class _SaveModelsButtonState extends State<SaveModelsButton> {
  TextEditingController textFieldController;

  @override
  void initState() {
    super.initState();

    textFieldController = TextEditingController();
  }

  @override
  void dispose() {
    textFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: LayerScreenBottomButtonBoxDecoration,
      child: FlatButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext ctx) {
                return AlertDialog(
                  title: Text("Do you want to save the Model?"),
                  content: TextField(
                    decoration: InputDecoration(hintText: "Name of your Model"),
                    controller: textFieldController,
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Text("cancel"),
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                    ),
                    FlatButton(
                      child: Text("save"),
                      onPressed: () {
                        String modelName = textFieldController.text;
                        saveModel(this.widget.parent.layers, modelName);
                        Navigator.of(ctx).pop();
                      },
                    ),
                  ],
                );
              });
        },
        child: Text(
          "Save Model",
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}

class NewLayerButton extends StatelessWidget {
  final _LayerScreenState parent;

  const NewLayerButton({Key key, @required this.parent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: LayerScreenBottomButtonBoxDecoration,
      margin: EdgeInsets.all(10.0),
      child: FlatButton(
        onPressed: () {
          this.parent.bottomSheet = showBottomSheet(
            context: context,
            builder: (context) =>
                NewLayerSubScreen(updateUiFunction: this.parent.scrollToBottom),
          );
          this.parent.setIsSubScreenShown(true);
          this
              .parent
              .bottomSheet
              .closed
              .then((value) => this.parent.setIsSubScreenShown(false));
        },
        child: Text(
          "new Layer",
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
