import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/widgets.dart';
import 'package:uuid/uuid.dart';

import '../enums/model_enums.dart';
import '../extensions/model_extension.dart';
import 'child_model.dart';
import 'property_model.dart';

const uuid = Uuid();

abstract class WidgetModel {
  late final String id;

  late final ModelType type;

  // ignore: strict_raw_type
  late final Map<String, PropertyModel> properties;

  late final Map<String, ChildModel> children;

  bool get isParent => children.isNotEmpty;

  Widget toWidget();

  String toCode();

  WidgetModel copyWith({
    final String? id,
    // ignore: strict_raw_type
    final Map<String, PropertyModel>? properties,
    final Map<String, ChildModel>? children,
  });

  Map<String, dynamic> toJson() => <String, dynamic>{
        "id": id,
        'type': EnumToString.convertToString(type),
        "properties": properties
            .map((final key, final value) => MapEntry(key, value.toJson())),
        "children": children
            .map((final key, final value) => MapEntry(key, value.toJson())),
      };

  static WidgetModel fromJson(final Map<String, dynamic> json) {
    final type = json["type"] as String?;
    if (type == null) throw Error();
    final model = EnumToString.fromString<ModelType>(ModelType.values, type);
    if (model == null) throw Error();

    return model.fromJson(json);
  }
}
