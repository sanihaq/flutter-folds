// This file is "main.dart"
// ignore_for_file: prefer_final_parameters

import 'package:freezed_annotation/freezed_annotation.dart';

part 'folds_file.freezed.dart';
part 'folds_file.g.dart';

@freezed
class FoldsFile with _$FoldsFile {
  const factory FoldsFile({
    required String name,
    required String id,
    required String fileId,
    required DateTime createdAt,
    required DateTime modifiedAt,
  }) = _FoldsFile;

  factory FoldsFile.fromJson(Map<String, Object?> json) =>
      _$FoldsFileFromJson(json);
}
