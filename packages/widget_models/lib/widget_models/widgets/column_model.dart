import 'package:flutter/material.dart' hide ColorProperty;

import '../../enums/child_enums.dart';
import '../../enums/model_enums.dart';
import '../../models/child_model.dart';
import '../../models/property_model.dart';
import '../../models/widget_model.dart';
import '../../property_models/cross_axis_alignment_model.dart';
import '../../property_models/key_model.dart';
import '../../property_models/main_axis_alignment_model.dart';
import '../../property_models/main_axis_size_model.dart';
import '../../property_models/text_baseline_model.dart';
import '../../property_models/text_direction_model.dart';
import '../../property_models/vertical_direction_model.dart';
import '../../utils/utils.dart';

@immutable
class ColumnModel extends WidgetModel {
  ColumnModel({
    final String? id,
    final Map<String, PropertyModel>? properties,
    final Map<String, ChildModel>? children,
  }) {
    super.id = id ?? generateUniqueId();
    super.type = ModelType.column;
    super.properties = joinMaps(properties ?? {}, {
      "key": KeyProperty(),
      "mainAxisAlignment": MainAxisAlignmentProperty(),
      "mainAxisSize": MainAxisSizeProperty(),
      "crossAxisAlignment": CrossAxisAlignmentProperty(),
      "textDirection": TextDirectionProperty(),
      "verticalDirection": VerticalDirectionProperty(),
      "textBaseline": TextBaselineProperty(),
    });
    super.children = joinMaps<ChildModel>(children ?? {},
        {"children": const ChildModel(type: ChildType.children, children: [])});
  }

  @override
  Column toWidget() {
    return Column(
      key: (super.properties["key"] as KeyProperty?)?.resolveValue(),
      mainAxisAlignment:
          (super.properties["mainAxisAlignment"] as MainAxisAlignmentProperty?)
                  ?.resolveValue() ??
              MainAxisAlignment.start,
      mainAxisSize: (super.properties["mainAxisSize"] as MainAxisSizeProperty?)
              ?.resolveValue() ??
          MainAxisSize.max,
      crossAxisAlignment: (super.properties["crossAxisAlignment"]
                  as CrossAxisAlignmentProperty?)
              ?.resolveValue() ??
          CrossAxisAlignment.center,
      textDirection:
          (super.properties["textDirection"] as TextDirectionProperty?)
              ?.resolveValue(),
      verticalDirection:
          (super.properties["verticalDirection"] as VerticalDirectionProperty?)
                  ?.resolveValue() ??
              VerticalDirection.down,
      textBaseline: (super.properties["textBaseline"] as TextBaselineProperty?)
          ?.resolveValue(),
      children: super
              .children["children"]
              ?.children
              .map((e) => e.toWidget())
              .toList() ??
          [],
    );
  }

  @override
  String toCode() {
    final key = properties["key"];
    final mainAxisAlignment = properties["mainAxisAlignment"];
    final mainAxisSize = properties["mainAxisSize"];
    final crossAxisAlignment = properties["crossAxisAlignment"];
    final textDirection = properties["textDirection"];
    final verticalDirection = properties["verticalDirection"];
    final textBaseline = properties["textBaseline"];
    final List<WidgetModel> _children = children["children"]?.children ?? [];
    return """
  Column(
    ${key?.resolveValue() == null ? "" : "key: ${key?.toCode()},"}
    ${mainAxisAlignment?.resolveValue() == null ? "" : "mainAxisAlignment: ${mainAxisAlignment?.toCode()},"}
    ${mainAxisSize?.resolveValue() == null ? "" : "mainAxisSize: ${mainAxisSize?.toCode()},"}
    ${crossAxisAlignment?.resolveValue() == null ? "" : "crossAxisAlignment: ${crossAxisAlignment?.toCode()},"}
    ${textDirection?.resolveValue() == null ? "" : "crossAxisAlignment: ${textDirection?.toCode()},"}
    ${verticalDirection?.resolveValue() == null ? "" : "crossAxisAlignment: ${verticalDirection?.toCode()},"}
    ${textBaseline?.resolveValue() == null ? "" : "crossAxisAlignment: ${textBaseline?.toCode()},"}
    ${_children.isEmpty ? "" : "children: ${_children.map((final e) => e.toCode()).toList()},"}
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
    return ColumnModel(
      id: id ?? super.id,
      properties: properties ?? super.properties,
      children: children ?? super.children,
    );
  }

  factory ColumnModel.fromJson(final Map<String, dynamic> json) => ColumnModel(
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
