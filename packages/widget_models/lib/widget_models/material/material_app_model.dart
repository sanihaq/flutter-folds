import 'package:flutter/material.dart' hide ColorProperty;

import '../../enums/model_enums.dart';
import '../../models/child_model.dart';
import '../../models/property_model.dart';
import '../../models/widget_model.dart';
import '../../property_models/key_model.dart';
import '../../utils/utils.dart';

@immutable
class MaterialAppModel extends WidgetModel {
  MaterialAppModel({
    final String? id,
    // ignore: strict_raw_type
    final Map<String, PropertyModel>? properties,
    final Map<String, ChildModel>? children,
  }) {
    super.id = id ?? generateUniqueId();
    super.type = ModelType.materialApp;
    super.properties = properties ??
        {
          "key": KeyProperty(),
        };
    super.children = children ?? {"home": const ChildModel(children: [])};
  }

  @override
  MaterialApp toWidget() {
    return MaterialApp(
      key: (super.properties["key"] as KeyProperty?)?.resolveValue(),
      home: super.children["home"]?.firstOrNull?.toWidget(),
    );
  }

  @override
  String toCode() {
    final key = properties["key"];
    final home = children["home"]?.firstOrNull;
    return """
  MaterialApp(
    ${key?.resolveValue() == null ? "" : "key: ${key?.toCode()},"}
    ${home == null ? "" : "child: ${home.toCode()},"}
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
    return MaterialAppModel(
      id: id ?? super.id,
      properties: properties ?? super.properties,
      children: children ?? super.children,
    );
  }

  factory MaterialAppModel.fromJson(final Map<String, dynamic> json) =>
      MaterialAppModel(
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
