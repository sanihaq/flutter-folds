// This file is "main.dart"
// ignore_for_file: prefer_final_parameters

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:localstore/localstore.dart';

import '../utils/db.dart';

part 'fold_file.freezed.dart';
part 'fold_file.g.dart';

@freezed
class FoldFile with _$FoldFile {
  const factory FoldFile({
    required String name,
    required String id,
    required String dataId,
    required DateTime createdAt,
    required DateTime modifiedAt,
  }) = _FoldFile;

  factory FoldFile.fromJson(Map<String, dynamic> json) =>
      _$FoldFileFromJson(json);
}

extension ExtTodo on FoldFile {
  Future<void> save() async {
    final db = Localstore.instance;
    return db.collection(Db.foldsCollectionName).doc(id).set(toJson());
  }

  Future<void> delete() async {
    final db = Localstore.instance;
    return db.collection(Db.foldsCollectionName).doc(id).delete();
  }

  Future<void> saveData(final List<Map<String, dynamic>> json) async {
    await Localstore.instance
        .collection(Db.foldsDataCollectionName)
        .doc(dataId)
        .set(<String, dynamic>{"data": json});
  }
}
