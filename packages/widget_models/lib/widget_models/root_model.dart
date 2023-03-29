import 'package:flutter/material.dart' hide ColorProperty;

import '../enums/model_enums.dart';
import '../models/child_model.dart';
import '../models/property_model.dart';
import '../models/widget_model.dart';
import '../property_models/double_model.dart';
import '../property_models/key_model.dart';
import '../utils/utils.dart';

@immutable
class RootModel extends WidgetModel {
  RootModel({
    required this.name,
    final String? id,
    final Map<String, PropertyModel>? properties,
    final Map<String, ChildModel>? children,
  }) {
    super.id = id ?? generateUniqueId();
    super.type = ModelType.root;
    super.properties = joinMaps(properties ?? {}, {"key": KeyProperty()});
    super.children = joinMaps<ChildModel>(
        children ?? {}, {"child": const ChildModel(children: [])});
  }

  final String name;

  @override
  Center toWidget() {
    return Center(
      key: (super.properties["key"] as KeyProperty?)?.resolveValue(),
      child: super.children["child"]?.firstOrNull?.toWidget(),
    );
  }

  @override
  String toCode() {
    final key = properties["key"];
    final child = children["child"]?.firstOrNull;
    return """
  Center(
    ${key?.resolveValue() == null ? "" : "key: ${key?.toCode()},"}
    ${child == null ? "" : "child: ${child.toCode()},"}
  )
"""
        .replaceAll("\n", "")
        .replaceAll(" ", "")
        .trim();
  }

  @override
  WidgetModel copyWith({
    final String? name,
    final String? id,
    final Map<String, PropertyModel>? properties,
    final Map<String, ChildModel>? children,
  }) {
    return RootModel(
      name: name ?? this.name,
      id: id ?? super.id,
      properties: properties ?? super.properties,
      children: children ?? super.children,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{"name": name}..addAll(super.toJson());
  }

  factory RootModel.fromJson(final Map<String, dynamic> json) => RootModel(
        name: json['name'] as String,
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
