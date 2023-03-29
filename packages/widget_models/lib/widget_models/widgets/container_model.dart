import 'package:flutter/material.dart' hide ColorProperty;

import '../../enums/model_enums.dart';
import '../../models/child_model.dart';
import '../../models/property_model.dart';
import '../../models/widget_model.dart';
import '../../property_models/alignment_model.dart';
import '../../property_models/box_constraints_model.dart';
import '../../property_models/clip_model.dart';
import '../../property_models/color_model.dart';
import '../../property_models/decoration_model.dart';
import '../../property_models/double_model.dart';
import '../../property_models/edge_insets_model.dart';
import '../../property_models/key_model.dart';
import '../../property_models/matrix4_model.dart';
import '../../utils/utils.dart';

@immutable
class ContainerModel extends WidgetModel {
  ContainerModel({
    final String? id,
    final Map<String, PropertyModel>? properties,
    final Map<String, ChildModel>? children,
  }) {
    super.id = id ?? generateUniqueId();
    super.type = ModelType.container;
    super.properties = joinMaps(properties ?? {}, {
      "key": KeyProperty(),
      "alignment": AlignmentProperty(),
      "padding": EdgeInsetsProperty(),
      "color": ColorProperty(),
      "decoration": DecorationProperty(),
      "foregroundDecoration": DecorationProperty(),
      "width": DoubleProperty(),
      "height": DoubleProperty(),
      "constraints": BoxConstraintsProperty(),
      "margin": EdgeInsetsProperty(),
      "transform": Matrix4Property(),
      "transformAlignment": AlignmentProperty(),
      "clipBehavior": ClipProperty(),
    });
    super.children = joinMaps<ChildModel>(
        children ?? {}, {"child": const ChildModel(children: [])});
  }

  @override
  Container toWidget() {
    return Container(
      key: (super.properties["key"] as KeyProperty?)?.resolveValue(),
      alignment:
          (super.properties["alignment"] as AlignmentProperty?)?.resolveValue(),
      padding:
          (super.properties["padding"] as EdgeInsetsProperty?)?.resolveValue(),
      color: (super.properties["color"] as ColorProperty?)?.resolveValue(),
      decoration: (super.properties["decoration"] as DecorationProperty?)
          ?.resolveValue(),
      foregroundDecoration:
          (super.properties["foregroundDecoration"] as DecorationProperty?)
              ?.resolveValue(),
      width: (super.properties["width"] as DoubleProperty?)?.resolveValue(),
      height: (super.properties["height"] as DoubleProperty?)?.resolveValue(),
      constraints: (super.properties["constraints"] as BoxConstraintsProperty?)
          ?.resolveValue(),
      margin:
          (super.properties["margin"] as EdgeInsetsProperty?)?.resolveValue(),
      transform:
          (super.properties["transform"] as Matrix4Property?)?.resolveValue(),
      transformAlignment:
          (super.properties["transformAlignment"] as AlignmentProperty?)
              ?.resolveValue(),
      clipBehavior:
          (super.properties["clipBehavior"] as ClipProperty?)?.resolveValue() ??
              Clip.none,
      child: super.children["child"]?.firstOrNull?.toWidget(),
    );
  }

  @override
  String toCode() {
    final key = properties["key"];
    final alignment = properties["alignment"];
    final padding = properties["padding"];
    final color = properties["color"];
    final decoration = properties["decoration"];
    final foregroundDecoration = properties["foregroundDecoration"];
    final width = properties["width"];
    final height = properties["height"];
    final constraints = properties["constraints"];
    final margin = properties["margin"];
    final transform = properties["transform"];
    final transformAlignment = properties["transformAlignment"];
    final clipBehavior = properties["clipBehavior"];
    final child = children["child"]?.firstOrNull;
    return """
  Container(
    ${key?.resolveValue() == null ? "" : "key: ${key?.toCode()},"}
    ${alignment?.resolveValue() == null ? "" : "widthFactor: ${alignment?.toCode()},"}
    ${padding?.resolveValue() == null ? "" : "heightFactor: ${padding?.toCode()},"}
    ${color?.resolveValue() == null ? "" : "heightFactor: ${color?.toCode()},"}
    ${decoration?.resolveValue() == null ? "" : "heightFactor: ${decoration?.toCode()},"}
    ${foregroundDecoration?.resolveValue() == null ? "" : "heightFactor: ${foregroundDecoration?.toCode()},"}
    ${width?.resolveValue() == null ? "" : "heightFactor: ${width?.toCode()},"}
    ${height?.resolveValue() == null ? "" : "heightFactor: ${height?.toCode()},"}
    ${constraints?.resolveValue() == null ? "" : "heightFactor: ${constraints?.toCode()},"}
    ${margin?.resolveValue() == null ? "" : "heightFactor: ${margin?.toCode()},"}
    ${transform?.resolveValue() == null ? "" : "heightFactor: ${transform?.toCode()},"}
    ${transformAlignment?.resolveValue() == null ? "" : "heightFactor: ${transformAlignment?.toCode()},"}
    ${clipBehavior?.resolveValue() == null ? "" : "heightFactor: ${clipBehavior?.toCode()},"}
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
    return ContainerModel(
      id: id ?? super.id,
      properties: properties ?? super.properties,
      children: children ?? super.children,
    );
  }

  factory ContainerModel.fromJson(final Map<String, dynamic> json) =>
      ContainerModel(
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
