import 'package:flutter/material.dart';
import 'package:imageshapecalculator/models/layerDB.dart';
import 'package:imageshapecalculator/models/layers.dart';
import 'package:imageshapecalculator/constants.dart';

class SaveModelButton extends StatefulWidget {
  final Layers layers;
  final LayerDB layerDB;

  const SaveModelButton({
    Key key,
    @required this.layers,
    @required this.layerDB,
  }) : super(key: key);

  @override
  _SaveModelButtonState createState() => _SaveModelButtonState();
}

class _SaveModelButtonState extends State<SaveModelButton> {
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
                        if (modelName == null) {
                          modelName = "nameless";
                        }
                        this
                            .widget
                            .layerDB
                            .saveModel(this.widget.layers, modelName);
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
