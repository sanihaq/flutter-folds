import 'package:flutter/material.dart' hide ColorProperty;

import '../../enums/model_enums.dart';
import '../../models/child_model.dart';
import '../../models/property_model.dart';
import '../../models/widget_model.dart';
import '../../property_models/double.dart';
import '../../property_models/key.dart';

@immutable
class CenterModel extends WidgetModel {
  CenterModel({
    final String? id,
    // ignore: strict_raw_type
    final Map<String, PropertyModel>? properties,
    final Map<String, ChildModel>? children,
  }) {
    super.id = id ?? uuid.v4();
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
  Widget toWidget() {
    return Center(
      key: (super.properties["key"]! as KeyProperty).resolveValue(),
      widthFactor:
          (super.properties["widthFactor"]! as DoubleProperty).resolveValue(),
      heightFactor:
          (super.properties["heightFactor"]! as DoubleProperty).resolveValue(),
      child: super.children["child"]?.firstOrNull?.toWidget(),
    );
  }

  @override
  String toCode() {
    return """
  Center(
    key: ${properties["key"]?.toCode()},
    widthFactor: ${properties["widthFactor"]?.toCode()},
    heightFactor: ${properties["heightFactor"]?.toCode()},
    child: ${children["child"]?.firstOrNull?.toCode()},
  )
""";
  }

  @override
  WidgetModel copyWith({
    final String? id,
    // ignore: strict_raw_type
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
        properties: (json['properties'] as Map<String, Map<String, dynamic>>)
            .map((final key, final value) =>
                MapEntry(key, PropertyModel.fromJson(value))),
        children: (json['children'] as Map<String, Map<String, dynamic>>).map(
          (final key, final value) => MapEntry(key, ChildModel.fromJson(value)),
        ),
      );
}
