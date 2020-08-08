import 'package:flutter/material.dart';
import 'package:imageshapecalculator/main.dart';
import 'package:imageshapecalculator/models/evaluateLayers.dart';
import 'package:imageshapecalculator/models/layerDB.dart';
import 'package:imageshapecalculator/screens/newLayerSubScreen.dart';
import 'package:imageshapecalculator/widgets/infoButton.dart';
import 'package:imageshapecalculator/widgets/loadModelButton.dart';
import 'package:imageshapecalculator/widgets/saveModelButton.dart';
import 'package:imageshapecalculator/widgets/newLayerButton.dart';

import 'package:provider/provider.dart';

import 'package:imageshapecalculator/models/layers.dart';

class LayerScreen extends StatefulWidget {
  @override
  LayerScreenState createState() => LayerScreenState();
}

class LayerScreenState extends State<LayerScreen> {
  ScrollController scrollController;
  bool isSubScreenShown = false;
  PersistentBottomSheetController bottomSheet;
  Layers layers;
  LayerDB layerDB;

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
    // Getting the Layers from the Provider:
    ProviderData providerData = Provider.of<ProviderData>(context);
    this.layerDB = providerData.layerDB;
    this.layers = providerData.layers;
    layers.setUpdateUiFunction(updateUi);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: GestureDetector(
            onTap: () {
              if (this.isSubScreenShown) bottomSheet.close();
            },
            child: Stack(
              children: <Widget>[
                Column(
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                LoadModelButton(parent: this),
                                SaveModelButton(
                                    layers: this.layers, layerDB: layerDB),
                                NewLayerButton(parent: this),
                              ],
                            ),
                          )
                  ],
                ),
                Positioned(
                  right: 3,
                  top: 3,
                  child: InfoButton(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
