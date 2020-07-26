import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:imageshapecalculator/widgets/newLayerSubScreen.dart';
import 'package:imageshapecalculator/models/layers.dart';

class LayerScreen extends StatefulWidget {
  @override
  _LayerScreenState createState() => _LayerScreenState();
}

class _LayerScreenState extends State<LayerScreen> {
  ScrollController scrollController;
  bool isSubScreenShown = false;
  PersistentBottomSheetController bottomSheet;

  @override
  void initState() {
    super.initState();

    this.scrollController = ScrollController();
  }

  void scrollToBottom() {
    double maxScrollPosition = this.scrollController.position.maxScrollExtent;
    print(maxScrollPosition);
    this.scrollController.jumpTo(maxScrollPosition);
  }

  setIsSubScreenShown(bool value) {
    setState(() {
      this.isSubScreenShown = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Geting the Layers from the Provider:
    Layers layers = Provider.of<Layers>(context);

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
                            NewLayerButton(
                              updateUiFunction: () {
                                setState(() {});
                                scrollToBottom();
                              },
                              isSubScreenShownFunction: setIsSubScreenShown,
                              parrent: this,
                            ),
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
  final Function updateUiFunction;
  final Function isSubScreenShownFunction;
  final _LayerScreenState parrent;

  const NewLayerButton(
      {Key key,
      @required this.updateUiFunction,
      @required this.isSubScreenShownFunction,
      @required this.parrent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        this.parrent.bottomSheet = showBottomSheet(
          context: context,
          builder: (context) =>
              NewLayerSubScreen(updateUiFunction: this.updateUiFunction),
        );
        isSubScreenShownFunction(true);

        this
            .parrent
            .bottomSheet
            .closed
            .then((value) => isSubScreenShownFunction(false));
      },
      child: Text("new Layer"),
    );
  }
}
