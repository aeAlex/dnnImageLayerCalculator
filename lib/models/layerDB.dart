import 'package:imageshapecalculator/models/ImageData.dart';
import 'package:imageshapecalculator/models/layerData.dart';
import 'package:imageshapecalculator/models/rectangle.dart';
import 'package:imageshapecalculator/widgets/dismissableListViewItem.dart';
import 'package:imageshapecalculator/widgets/toggleableInputLayer.dart';
import 'package:sqflite/sqflite.dart';

import 'layers.dart';

class LayerDB {
  Future<Database> futureDB;

  LayerDB() {
    openLayerDB();
  }

  void openLayerDB() async {
    //print(await getDatabasesPath());
    // => /data/user/0/alexandereineder.imageshapecalculator/databases
    Future<Database> futureDB =
        openDatabase('model_db.db', version: 1, onCreate: (db, version) {
      print("Creating Database");

      db.execute("CREATE TABLE rectangle ("
          "rectangle_id INTEGER PRIMARY KEY, "
          "width INTEGER,"
          "height INTEGER"
          ")");

      db.execute("CREATE TABLE layerType ("
          "layerType_id INTEGER PRIMARY KEY, "
          "name VARCHAR(255)"
          ")");

      db.execute("CREATE TABLE image ("
          "image_id INTEGER PRIMARY KEY, "
          "imageSize_id INTEGER, "
          "depth INTEGER"
          ")");

      db.execute("CREATE TABLE model ("
          "model_id INTEGER PRIMARY KEY, "
          "inputImage_id INTEGER, "
          "name VARCHAR(255), "
          "creationTime DATETIME DEFAULT current_timestamp"
          ")");

      db.execute("CREATE TABLE layer ("
          "layer_id INTEGER PRIMARY KEY AUTOINCREMENT, "
          "layerType_id INTEGER, "
          "kernel_id INTEGER, "
          "stride_id INTEGER, "
          "model_id INTEGER, "
          "anzFilter INTEGER, "
          "padding INTEGER "
          ")");

      LayerType.values.forEach((LayerType type) {
        db.rawInsert(
            "INSERT INTO layerType (layerType_id, name) VALUES (${type.index}, '${type.toString()}')");
      });
    });

    //Database db = await futureDB;
    //final List<Map<String, dynamic>> maps = await db.query('layerType');
    //print(maps);

    this.futureDB = futureDB;
  }

  void saveModel(Layers layers, String name) async {
    Database db = await this.futureDB;
    print("Saving Model");

    int modelId = await this._createModelAndInputImage(layers, name);

    for (int i = 1; i < layers.layerList.length; i++) {
      if (layers.layerList[i] is DismissableListViewItem) {
        DismissableListViewItem disLvItem =
            layers.layerList[i] as DismissableListViewItem;
        LayerData layerData = disLvItem.layerData;
        Map<String, dynamic> layerMapWithRectangles = layerData.toMap();
        Map<String, dynamic> layerMap = {};
        // Replace the Rectangles with ids:
        layerMapWithRectangles.forEach((key, value) async {
          if (!(layerMapWithRectangles[key] is Rectangle)) {
            print("$key is not a Rectangle");
            layerMap[key] = value;
          }
        });
        print("layerMap before: $layerMap");
        layerMap['kernel_id'] =
            await _createReactangle(layerMapWithRectangles['kernel']);
        layerMap['stride_id'] =
            await _createReactangle(layerMapWithRectangles['stride']);
        layerMap['layerType_id'] = layerData.layerType.index;
        layerMap['model_id'] = modelId;
        print("layerMap: $layerMap");
        // Saving in Database:
        db.insert('layer', layerMap);
      } else {
        throw ("Not a DissmissableListViewItem");
      }
    }

    final List<Map<String, dynamic>> maps = await db.query('layer');
    print(maps);
  }

  Future<int> _createModelAndInputImage(Layers layers, String name) async {
    Database db = await this.futureDB;

    int inputImageId = await this._createInputImage(layers);
    int modelId = await this._getCurrentIndex("model", "model_id");

    Map<String, dynamic> modelMap = {
      'model_id': modelId,
      'inputImage_id': inputImageId,
      'name': name
    };

    db.insert("model", modelMap);

    final List<Map<String, dynamic>> maps = await db.query('model');
    print(maps);

    return modelId;
  }

  Future<int> _createInputImage(Layers layers) async {
    Database db = await this.futureDB;
    // creation of the Model and of the inputImage:
    ToggleableInputLayer inputLayer =
        layers.layerList[0] as ToggleableInputLayer;
    ImageData imageData = inputLayer.inputLayerData;

    int imageSizeId = await this._createReactangle(imageData.imageSize);
    int imageId = await this._getCurrentIndex("image", "image_id");

    Map<String, dynamic> imageMap = {
      'image_id': imageId,
      'imageSize_id': imageSizeId,
      'depth': imageData.depth,
    };

    db.insert('image', imageMap);

    final List<Map<String, dynamic>> maps = await db.query('image');
    print(maps);

    return imageId;
  }

  Future<int> _createReactangle(Rectangle rectangle) async {
    Database db = await this.futureDB;

    int index = await _getCurrentIndex("rectangle", "rectangle_id");

    Map<String, dynamic> rectangleMap = rectangle.toMap();
    rectangleMap["rectangle_id"] = index;

    db.insert('rectangle', rectangleMap);

    final List<Map<String, dynamic>> maps = await db.query('rectangle');
    print(maps);

    return index;
  }

  Future<int> _getCurrentIndex(String tableName, String tableID) async {
    Database db = await this.futureDB;
    Map<String, dynamic> maxIndexMap = (await db
        .rawQuery("SELECT MAX($tableID) as maxIndex FROM $tableName"))[0];
    int maxIndex = maxIndexMap['maxIndex'];
    int index = (maxIndex == null) ? 1 : maxIndex + 1;
    return index;
  }
}

enum LayerType { ConvolutionalLayer, MaxPoolLayer }
