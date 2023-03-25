import 'package:flutter/material.dart' hide ColorProperty;

import '../../enums/model_enums.dart';
import '../../models/child_model.dart';
import '../../models/property_model.dart';
import '../../models/widget_model.dart';
import '../../property_models/key_model.dart';
import '../../utils/utils.dart';

@immutable
class ScaffoldModel extends WidgetModel {
  ScaffoldModel({
    final String? id,
    // ignore: strict_raw_type
    final Map<String, PropertyModel>? properties,
    final Map<String, ChildModel>? children,
  }) {
    super.id = id ?? generateUniqueId();
    super.type = ModelType.scaffold;
    super.properties = properties ??
        {
          "key": KeyProperty(),
        };
    super.children = children ?? {"body": const ChildModel(children: [])};
  }

  @override
  Scaffold toWidget() {
    return Scaffold(
      key: (super.properties["key"] as KeyProperty?)?.resolveValue(),
      body: super.children["body"]?.firstOrNull?.toWidget(),
    );
  }

  @override
  String toCode() {
    final key = properties["key"];
    final body = children["body"]?.firstOrNull;
    return """
  Scaffold(
    ${key?.resolveValue() == null ? "" : "key: ${key?.toCode()},"}
    ${body == null ? "" : "child: ${body.toCode()},"}
  )
"""
        .replaceAll("\n", "")
        .replaceAll(" ", "")
        .trim();
  }

  @override
  WidgetModel copyWith({
    final String? id,
    // ignore: strict_raw_type
    final Map<String, PropertyModel>? properties,
    final Map<String, ChildModel>? children,
  }) {
    return ScaffoldModel(
      id: id ?? super.id,
      properties: properties ?? super.properties,
      children: children ?? super.children,
    );
  }

  factory ScaffoldModel.fromJson(final Map<String, dynamic> json) =>
      ScaffoldModel(
        id: json['id'] as String,
        properties:
            Map<String, Map<String, dynamic>>.from(json['properties'] as Map)
                .map((final key, final value) =>
                    MapEntry(key, PropertyModel.fromJson(value))),
        children:
            Map<String, Map<String, dynamic>>.from(json['children'] as Map).map(
          (final key, final value) => MapEntry(key, ChildModel.fromJson(value)),
        ),
      );
}
