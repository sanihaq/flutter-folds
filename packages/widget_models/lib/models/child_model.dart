// ignore_for_file: invalid_annotation_target

import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/widgets.dart';

import '../enums/child_enums.dart';
import 'widget_model.dart';

@immutable
class ChildModel {
  const ChildModel({required this.children, this.type = ChildType.child});

  final List<WidgetModel> children;
  final ChildType type;

  // check if more model is accepted or not
  bool get canAcceptChild => type == ChildType.children || children.isEmpty;

  WidgetModel? get firstOrNull => children.isNotEmpty ? children.first : null;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'type': EnumToString.convertToString(type),
        'children': children.map((final e) => e.toJson()).toList(),
      };

  factory ChildModel.fromJson(final Map<String, dynamic> json) {
    final type = json["type"] as String?;
    return ChildModel(
      children: (json['children'] as List<Map<String, dynamic>>)
          .map((final e) => WidgetModel.fromJson(e))
          .toList(),
      type: EnumToString.fromString(ChildType.values, type ?? "child") ??
          ChildType.child,
    );
  }
}
