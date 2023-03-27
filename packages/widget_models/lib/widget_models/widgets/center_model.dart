import 'package:flutter/material.dart' hide ColorProperty;

import '../../enums/model_enums.dart';
import '../../models/child_model.dart';
import '../../models/property_model.dart';
import '../../models/widget_model.dart';
import '../../property_models/double_model.dart';
import '../../property_models/key_model.dart';
import '../../utils/utils.dart';

@immutable
class CenterModel extends WidgetModel {
  CenterModel({
    final String? id,
    final Map<String, PropertyModel>? properties,
    final Map<String, ChildModel>? children,
  }) {
    super.id = id ?? generateUniqueId();
    super.type = ModelType.center;
    super.properties = properties ??
        {
          "key": KeyProperty(),
          "widthFactor": DoubleProperty(),
          "heightFactor": DoubleProperty(),
        };
    super.children = children ?? {"child": const ChildModel(children: [])};
  }

  @override
  Center toWidget() {
    return Center(
      key: (super.properties["key"] as KeyProperty?)?.resolveValue(),
      widthFactor:
          (super.properties["widthFactor"] as DoubleProperty?)?.resolveValue(),
      heightFactor:
          (super.properties["heightFactor"] as DoubleProperty?)?.resolveValue(),
      child: super.children["child"]?.firstOrNull?.toWidget(),
    );
  }

  @override
  String toCode() {
    final key = properties["key"];
    final widthFactor = properties["widthFactor"];
    final heightFactor = properties["heightFactor"];
    final child = children["child"]?.firstOrNull;
    return """
  Center(
    ${key?.resolveValue() == null ? "" : "key: ${key?.toCode()},"}
    ${widthFactor?.resolveValue() == null ? "" : "widthFactor: ${widthFactor?.toCode()},"}
    ${heightFactor?.resolveValue() == null ? "" : "heightFactor: ${heightFactor?.toCode()},"}
    ${child == null ? "" : "child: ${child.toCode()},"}
  )
"""
        .replaceAll("\n", "")
        .replaceAll(" ", "")
        .trim();
  }

  @override
  WidgetModel copyWith({
    final String? id,
    final Map<String, PropertyModel>? properties,
    final Map<String, ChildModel>? children,
  }) {
    return CenterModel(
      id: id ?? super.id,
      properties: properties ?? super.properties,
      children: children ?? super.children,
    );
  }

  factory CenterModel.fromJson(final Map<String, dynamic> json) => CenterModel(
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
