import 'package:imageshapecalculator/models/ImageData.dart';
import 'package:imageshapecalculator/models/convolutionalLayerData.dart';
import 'package:imageshapecalculator/models/layerData.dart';
import 'package:imageshapecalculator/models/maxpoolingLayerData.dart';
import 'package:imageshapecalculator/models/rectangle.dart';
import 'package:imageshapecalculator/models/savedModelData.dart';
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
            layerMap[key] = value;
          }
        });
        layerMap['kernel_id'] =
            await _createReactangle(layerMapWithRectangles['kernel']);
        layerMap['stride_id'] =
            await _createReactangle(layerMapWithRectangles['stride']);
        layerMap['layerType_id'] = layerData.layerType.index;
        layerMap['model_id'] = modelId;

        // Saving in Database:
        db.insert('layer', layerMap);
      } else {
        throw ("Not a DissmissableListViewItem");
      }
    }
  }

  Future<List<SavedModelData>> queryModelDataList() async {
    Database db = await this.futureDB;
    List<Map<String, dynamic>> modelMap = await db.query('model');
    List<SavedModelData> savedModelDataList = <SavedModelData>[];

    modelMap.forEach((Map<String, dynamic> map) {
      int modelId = map['model_id'];
      int inputImageId = map['inputImage_id'];
      String name = map['name'];
      String creationTimeString = map['creationTime'];
      savedModelDataList.add(SavedModelData(
          modelId: modelId,
          inputImageId: inputImageId,
          name: name,
          creationTimeString: creationTimeString));
    });

    return savedModelDataList;
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

    return imageId;
  }

  Future<int> _createReactangle(Rectangle rectangle) async {
    Database db = await this.futureDB;

    int index = await _getCurrentIndex("rectangle", "rectangle_id");

    Map<String, dynamic> rectangleMap = rectangle.toMap();
    rectangleMap["rectangle_id"] = index;

    db.insert('rectangle', rectangleMap);

    return index;
  }

  // TODO: CREATE A DATABASEHELPER
  Future<int> _getCurrentIndex(String tableName, String tableID) async {
    Database db = await this.futureDB;
    Map<String, dynamic> maxIndexMap = (await db
        .rawQuery("SELECT MAX($tableID) as maxIndex FROM $tableName"))[0];
    int maxIndex = maxIndexMap['maxIndex'];
    int index = (maxIndex == null) ? 1 : maxIndex + 1;
    return index;
  }

  Future<ImageData> queryInputImageFromId(int inputImageId) async {
    Database db = await this.futureDB;

    // query Data From Image
    List<Map<String, dynamic>> imageMapList = await db.query('image',
        where: "image_id = ?", whereArgs: [inputImageId], limit: 1);

    Map<String, dynamic> imageMap = imageMapList[0];
    int imageSizeId = imageMap['imageSize_id'];
    int depth = imageMap['depth'];

    Rectangle imageSize = await _queryRectangleFromID(imageSizeId);

    return ImageData(imageSize: imageSize, depth: depth);
  }

  Future<Rectangle> _queryRectangleFromID(int rectangleId) async {
    Database db = await this.futureDB;

    // query Data from Rectangle
    List<Map<String, dynamic>> rectangleMapList = await db.query('rectangle',
        where: "rectangle_id = ?", whereArgs: [rectangleId], limit: 1);

    Map<String, dynamic> rectangleMap = rectangleMapList[0];
    return Rectangle(w: rectangleMap['width'], h: rectangleMap['height']);
  }

  Future<List<LayerData>> queryLayerDataFromId(int modelId) async {
    Database db = await this.futureDB;
    List<LayerData> layerDataList = <LayerData>[];

    // query Data from Layer
    List<Map<String, dynamic>> layerMapList =
        await db.query('layer', where: "model_id = ?", whereArgs: [modelId]);

    for (Map<String, dynamic> map in layerMapList) {
      LayerType layerType = getLayerTypeFromId(map['layerType_id']);
      Rectangle kernel = await _queryRectangleFromID(map['kernel_id']);
      Rectangle stride = await _queryRectangleFromID(map['stride_id']);
      int padding = map['padding'];
      int anzFilter = map['anzFilter'];

      switch (layerType) {
        case LayerType.ConvolutionalLayer:
          LayerData layerData = ConvolutionalLayerData(
              kernel: kernel,
              stride: stride,
              padding: padding,
              anzFilter: anzFilter);
          layerDataList.add(layerData);
          break;
        case LayerType.MaxPoolLayer:
          LayerData layerData =
              MaxPoolingLayerData(kernel: kernel, stride: stride);
          layerDataList.add(layerData);
          break;
      }
    }

    return layerDataList;
  }

  void deleteModel(SavedModelData savedModelData) async {
    Database db = await this.futureDB;
    // deleting the associated tuples with their Rectangles
    deleteLayerWithRectanglesFromId(savedModelData.modelId);
    deleteImageWithRectanglesFromId(savedModelData.inputImageId);

    db.delete(
      "model",
      where: "model_id = ?",
      whereArgs: [savedModelData.modelId],
    );
  }

  void deleteLayerWithRectanglesFromId(int modeId) async {
    Database db = await this.futureDB;
    // Deleting the rectangles
    List<Map<String, dynamic>> result = await db.rawQuery(
        "SELECT kernel_id, stride_id FROM layer WHERE model_id = ?", [modeId]);
    for (var map in result) {
      db.delete('rectangle',
          where: "rectangle_id IN (?, ?)",
          whereArgs: [map['kernel_id'], map['stride_id']]);
    }
    // Deleting the Layers
    db.delete("layer", where: "model_id = ?", whereArgs: [modeId]);
  }

  void deleteImageWithRectanglesFromId(int imageId) async {
    Database db = await this.futureDB;
    // Deleting the Rectangles
    List<Map<String, dynamic>> result = await db.rawQuery(
        "SELECT imageSize_id FROM image WHERE image_id = ?", [imageId]);
    if (result.length != 1) throw ("did not find a image or to many to delete");
    var map = result[0];
    db.delete("rectangle",
        where: "rectangle_id = ?", whereArgs: [map['imageSize_id']]);
    // Deleting the Image
    db.delete("image", where: "image_id = ?", whereArgs: [imageId]);
  }
}

LayerType getLayerTypeFromId(int id) {
  return LayerType.values[id];
}

enum LayerType { ConvolutionalLayer, MaxPoolLayer }
