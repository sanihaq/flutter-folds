import 'package:localstore/localstore.dart';

import '../models/folds_file.dart';

class Db {
  static const foldsFileDataCollection = "folds-files";
  static const foldsCollection = "flutter-folds";

  static Db? _instance;

  Db._() {
    db = Localstore.instance;
  }

  late final Localstore db;

  final List<FoldsFile> files = [];

  // Stream<Map<String, dynamic>> get files =>
  //     db.collection(foldsFileDataCollection).stream;

  Future<void> getFiles() async {
    final values =
        (await db.collection(foldsFileDataCollection).get())?.values.toList() ??
            <Map<String, dynamic>>[];
    files.addAll(
        // ignore: implicit_dynamic_parameter
        values.map((final e) => FoldsFile.fromJson(e as Map<String, Object?>)));
  }

  static Db get instance {
    return _instance ??= Db._();
  }

  Future<void> createExampleFold() async {
    final fold = await createNewFold("Default Fold", false);
    await saveData(fold.fileId, <String, dynamic>{});
  }

  Future<FoldsFile> createNewFold(final String name,
      [final bool isSaveData = true]) async {
    final file = FoldsFile(
      name: name,
      id: db.collection(foldsFileDataCollection).doc().id,
      fileId: db.collection(foldsCollection).doc().id,
      createdAt: DateTime.now(),
      modifiedAt: DateTime.now(),
    );
    await saveFold(file);
    if (isSaveData) {
      await saveData(file.fileId, <String, dynamic>{});
    }
    files.insert(0, file);
    return file;
  }

  Future<void> renameFold(final FoldsFile file) async {
    await saveFold(file);
    final i = files.indexWhere((final e) => e.id == file.id);
    files.removeAt(i);
    files.insert(i, file);
  }

  Future<void> saveFold(final FoldsFile file) async {
    await db
        .collection(foldsFileDataCollection)
        .doc(file.id)
        .set(file.toJson());
  }

  Future<void> saveData(
      final String fileId, final Map<String, dynamic> json) async {
    await db.collection(foldsCollection).doc(fileId).set(json);
  }

  Future<Map<String, dynamic>> getFold(final String? fileId) async {
    final data = await db.collection(foldsCollection).doc(fileId).get();
    return data ?? <String, dynamic>{};
  }

  Future<void> deleteFold(final FoldsFile file) async {
    await db.collection(foldsFileDataCollection).doc(file.id).delete();
    await db.collection(foldsCollection).doc(file.fileId).delete();
    files.removeWhere((final e) => e.id == file.id);
  }
}
