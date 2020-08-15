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
  LayerDB layerDB;

  @override
  Widget build(BuildContext context) {
    ProviderData providerData = Provider.of<ProviderData>(context);
    layerDB = providerData.layerDB;

    createLvItems(layerDB);

    return (this.lvItems != null && this.lvItems.length > 0)
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
        : Scaffold(
            body: Center(
              child: Container(
                child: Text(
                  "There are no saved Models",
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ),
          );
  }

  void createLvItems(LayerDB layerDB) async {
    if (this.lvItems == null) {
      List<SavedModelData> savedModelDataList =
          await layerDB.queryModelDataList();
      List<Widget> localLvItems = <Widget>[];
      savedModelDataList.forEach((SavedModelData savedModelData) {
        localLvItems.add(DismissibleModelSelectionCard(
            savedModelData: savedModelData, onDissmissed: this.deleteModel));
      });
      setState(() {
        this.lvItems = localLvItems;
      });
    }
  }

  void deleteModel(DismissibleModelSelectionCard modelSelectionCard) {
    if (this.lvItems.contains(modelSelectionCard)) {
      setState(() {
        this.lvItems.remove(modelSelectionCard);
      });
      layerDB.deleteModel(modelSelectionCard.savedModelData);
    }
  }
}

class DismissibleModelSelectionCard extends StatelessWidget {
  static const TextStyle bodyTextStyle =
      TextStyle(fontWeight: FontWeight.w400, fontSize: 16);

  final SavedModelData savedModelData;
  final Function onDissmissed;

  const DismissibleModelSelectionCard(
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
                          style: DismissibleModelSelectionCard.bodyTextStyle),
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
                          style: DismissibleModelSelectionCard.bodyTextStyle),
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
