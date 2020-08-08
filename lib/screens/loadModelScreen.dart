import 'package:flutter/material.dart';
import 'package:imageshapecalculator/main.dart';
import 'package:imageshapecalculator/models/layerDB.dart';
import 'package:imageshapecalculator/models/savedModelData.dart';
import 'package:imageshapecalculator/widgets/getDeleteIcon.dart';
import 'package:imageshapecalculator/widgets/layerCardExterior.dart';
import 'package:provider/provider.dart';

class LoadModelScreen extends StatefulWidget {
  @override
  _LoadModelScreenState createState() => _LoadModelScreenState();
}

class _LoadModelScreenState extends State<LoadModelScreen> {
  List<Widget> lvItems;

  @override
  Widget build(BuildContext context) {
    ProviderData providerData = Provider.of<ProviderData>(context);
    LayerDB layerDB = providerData.layerDB;

    createLvItems(layerDB);

    return (this.lvItems != null)
        ? Scaffold(
            body: SafeArea(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20.0),
                  Expanded(
                      child: ListView.builder(
                          itemCount: this.lvItems.length,
                          itemBuilder: (ctx, index) {
                            return this.lvItems[index];
                          })),
                ],
              ),
            ),
          )
        : Container();
  }

  void createLvItems(LayerDB layerDB) async {
    if (this.lvItems == null) {
      List<SavedModelData> savedModelDataList =
          await layerDB.queryModelDataList();
      List<Widget> localLvItems = <Widget>[];
      savedModelDataList.forEach((SavedModelData savedModelData) {
        localLvItems.add(ModelSelectionCard(
            savedModelData: savedModelData, onDissmissed: this.deleteModel));
      });
      setState(() {
        this.lvItems = localLvItems;
      });
    }
  }

  void deleteModel(ModelSelectionCard modelSelectionCard) {
    if (this.lvItems.contains(modelSelectionCard)) {
      setState(() {
        this.lvItems.remove(modelSelectionCard);
      });
    }
  }
}

class ModelSelectionCard extends StatelessWidget {
  static const TextStyle bodyTextStyle =
      TextStyle(fontWeight: FontWeight.w400, fontSize: 16);

  final SavedModelData savedModelData;
  final Function onDissmissed;

  const ModelSelectionCard(
      {Key key, @required this.savedModelData, @required this.onDissmissed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      child: GestureDetector(
        child: LayerCardExterior(
          color: Colors.orangeAccent,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Layer Name:"),
                      Text(this.savedModelData.name,
                          style: ModelSelectionCard.bodyTextStyle),
                    ],
                  ),
                ),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Creation Time:"),
                      Text(this.savedModelData.creationTimeString,
                          style: ModelSelectionCard.bodyTextStyle),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context, this.savedModelData);
        },
      ),
      onDismissed: (DismissDirection direction) {
        this.onDissmissed(this);

        Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('Deleted the "${this.savedModelData.name}" Model')));
      },
      background: getDeleteIcon(
          MainAxisAlignment.start, EdgeInsets.only(left: 20.0), 25),
      secondaryBackground: getDeleteIcon(
          MainAxisAlignment.end, EdgeInsets.only(right: 20.0), 25),
    );
  }
}
