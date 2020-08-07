import 'package:flutter/material.dart';
import 'package:imageshapecalculator/main.dart';
import 'package:imageshapecalculator/models/layerDB.dart';
import 'package:imageshapecalculator/models/savedModelData.dart';
import 'package:imageshapecalculator/widgets/layerCardExterior.dart';
import 'package:provider/provider.dart';

class LoadModelScreen extends StatefulWidget {
  @override
  _LoadModelScreenState createState() => _LoadModelScreenState();
}

class _LoadModelScreenState extends State<LoadModelScreen> {
  List<Widget> lvItems = <Widget>[];

  @override
  Widget build(BuildContext context) {
    ProviderData providerData = Provider.of<ProviderData>(context);
    LayerDB layerDB = providerData.layerDB;

    createLvItems(layerDB);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(height: 20.0),
            Expanded(
              child: ListView(children: lvItems),
            ),
          ],
        ),
      ),
    );
  }

  void createLvItems(LayerDB layerDB) async {
    if (this.lvItems.length == 0) {
      List<SavedModelData> savedModelDataList =
          await layerDB.queryModelDataList();
      List<Widget> localLvItems = <Widget>[];
      savedModelDataList.forEach((SavedModelData savedModelData) {
        localLvItems.add(ModelSelectionCard(savedModelData: savedModelData));
      });
      setState(() {
        this.lvItems = localLvItems;
      });
    }
  }
}

class ModelSelectionCard extends StatelessWidget {
  static const TextStyle bodyTextStyle =
      TextStyle(fontWeight: FontWeight.w400, fontSize: 16);

  final SavedModelData savedModelData;

  const ModelSelectionCard({Key key, @required this.savedModelData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
    );
  }
}
