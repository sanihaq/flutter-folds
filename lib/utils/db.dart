import 'package:localstore/localstore.dart';

import '../models/fold_file.dart';

class Db {
  static const foldsCollectionName = "folds-files";
  static const foldsDataCollectionName = "flutter-folds";

  static Db? _instance;

  Db._() {
    db = Localstore.instance;
  }

  late final Localstore db;

  final List<FoldFile> folds = [];

  Future<void> getFolds() async {
    final data = await db.collection(foldsCollectionName).get();
    final _folds = <FoldFile>[];
    if (data != null) {
      for (final map in data.values) {
        _folds.add(FoldFile.fromJson(Map<String, dynamic>.from(map as Map)));
      }
    }
    folds.addAll(_folds);
  }

  static Db get instance {
    return _instance ??= Db._();
  }

  Future<FoldFile> createExampleFold() async {
    final fold =
        await createNewFold("Default Fold", false, "3807U9B!", "7892F&14");
    await fold.saveData([
      <String, dynamic>{
        "name": "Default Root",
        "id": "7892F&14",
        "type": "root",
        "properties": <String, dynamic>{},
        "children": {
          "child": {
            "type": "child",
            "children": [
              {
                "id": "3836NXPA",
                "type": "center",
                "properties": <String, dynamic>{},
                "children": {
                  "child": {
                    "type": "child",
                    "children": [
                      {
                        "id": "3807U9B!",
                        "type": "container",
                        "properties": {
                          "color": {
                            "value": "materialColor",
                            "type": "color",
                            "resolver-property": {
                              "materialColor": {
                                "value": "blue",
                                "type": "materialColor"
                              }
                            }
                          },
                          "width": {"value": 100.0, "type": "double"},
                          "height": {"value": 100.0, "type": "double"}
                        },
                        "children": <String, dynamic>{}
                      }
                    ]
                  }
                }
              }
            ]
          }
        }
      }
    ]);
    // folds.insert(0, fold);
    return fold;
  }

  Future<FoldFile> createNewFold(
    final String name, [
    final bool isSaveData = true,
    final String? lastNode,
    final String? lastRoot,
  ]) async {
    final fold = FoldFile(
      name: name,
      id: db.collection(foldsCollectionName).doc().id,
      dataId: db.collection(foldsDataCollectionName).doc().id,
      createdAt: DateTime.now(),
      modifiedAt: DateTime.now(),
      lastNode: lastNode,
      lastRoot: lastRoot,
    );
    await saveFold(fold);
    if (isSaveData) {
      await fold.saveData([]);
    }
    folds.insert(0, fold);
    return fold;
  }

  Future<void> renameFold(final FoldFile file) async {
    await saveFold(file);
    final i = folds.indexWhere((final e) => e.id == file.id);
    folds.removeAt(i);
    folds.insert(i, file);
  }

  Future<void> saveFold(final FoldFile file) async {
    await file.save();
  }

  Future<List<Map<String, dynamic>>> getFold(final String? fileId) async {
    final data = await db.collection(foldsDataCollectionName).doc(fileId).get();
    return data != null
        ? List<Map<String, dynamic>>.from(data["data"] as List)
        : [];
  }

  Future<void> deleteFold(final FoldFile file) async {
    await file.delete();
    await db.collection(foldsDataCollectionName).doc(file.dataId).delete();
    folds.removeWhere((final e) => e.id == file.id);
  }

  Future<void> deleteAllFolds() async {
    await db.collection(foldsCollectionName).delete();
    await db.collection(foldsDataCollectionName).delete();
  }
}
