import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/widgets.dart';

import '../enums/model_enums.dart';
import '../extensions/model_extension.dart';
import 'child_model.dart';
import 'property_model.dart';

abstract class WidgetModel {
  late final String id;

  late final ModelType type;

  late final Map<String, PropertyModel> properties;

  late final Map<String, ChildModel> children;

  bool get isParent => children.isNotEmpty;

  Widget toWidget();

  String toCode();

  List<WidgetModel> getAllChildren() {
    final List<WidgetModel> _children = [];
    for (final key in children.keys) {
      _children.addAll(children[key]!.children);
    }
    return _children;
  }

  WidgetModel copyWith({
    final String? id,
    final Map<String, PropertyModel>? properties,
    final Map<String, ChildModel>? children,
  });

  Map<String, dynamic> toJson() => <String, dynamic>{
        "id": id,
        'type': EnumToString.convertToString(type),
        "properties": properties.map(
          (final key, final property) => property.value == property.defaultValue
              ? const MapEntry(null, null)
              : MapEntry(key, property.toJson()),
        )..remove(null),
        "children": children.map(
          (final key, final value) => value.children.isEmpty
              ? const MapEntry(null, null)
              : MapEntry(key, value.toJson()),
        )..remove(null),
      };

  static WidgetModel fromJson(final Map<String, dynamic> json) {
    final type = json["type"] as String?;
    if (type == null) throw Error();
    final model = EnumToString.fromString<ModelType>(ModelType.values, type);
    if (model == null) throw Error();

    return model.fromJson(json);
  }
}
