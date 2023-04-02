import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';

import '../enums/property_enums.dart';
import '../models/property_model.dart';

enum MaterialColorValueType {
  amber,
  blue,
  blueGrey,
  brown,
  cyan,
  deepOrange,
  deepPurple,
  green,
  grey,
  indigo,
  lightBlue,
  lightGreen,
  lime,
  orange,
  pink,
  purple,
  red,
  teal,
  yellow,
}

@immutable
class MateriaColorProperty extends PropertyModel<MaterialColorValueType?> {
  MateriaColorProperty({
    final MaterialColorValueType? value,
    final bool? isNullable,
    final bool? isReplaceable,
  }) {
    super.type = PropertyType.materialColor;
    super.value = value;
    super.isNullable = isNullable ?? true;
    super.isReplaceable = isReplaceable ?? false;
    super.resolverProperties = const {};
  }

  @override
  final List<MaterialColorValueType> availableValues =
      MaterialColorValueType.values;

  @override
  Color? resolveValue() {
    if (value == null) return null;
    switch (value!) {
      case MaterialColorValueType.amber:
        return Colors.amber;
      case MaterialColorValueType.blue:
        return Colors.blue;
      case MaterialColorValueType.blueGrey:
        return Colors.blueGrey;
      case MaterialColorValueType.brown:
        return Colors.brown;
      case MaterialColorValueType.cyan:
        return Colors.cyan;
      case MaterialColorValueType.deepOrange:
        return Colors.deepOrange;
      case MaterialColorValueType.deepPurple:
        return Colors.deepPurple;
      case MaterialColorValueType.green:
        return Colors.green;
      case MaterialColorValueType.grey:
        return Colors.grey;
      case MaterialColorValueType.indigo:
        return Colors.indigo;
      case MaterialColorValueType.lightBlue:
        return Colors.lightBlue;
      case MaterialColorValueType.lightGreen:
        return Colors.lightGreen;
      case MaterialColorValueType.lime:
        return Colors.lime;
      case MaterialColorValueType.orange:
        return Colors.orange;
      case MaterialColorValueType.pink:
        return Colors.pink;
      case MaterialColorValueType.purple:
        return Colors.purple;
      case MaterialColorValueType.red:
        return Colors.red;
      case MaterialColorValueType.teal:
        return Colors.teal;
      case MaterialColorValueType.yellow:
        return Colors.yellow;
    }
  }

  @override
  String toCode() {
    if (value == null) return "null";
    switch (value!) {
      case MaterialColorValueType.amber:
        return "Colors.amber";
      case MaterialColorValueType.blue:
        return "Colors.blue";
      case MaterialColorValueType.blueGrey:
        return "Colors.blueGrey";
      case MaterialColorValueType.brown:
        return "Colors.brown";
      case MaterialColorValueType.cyan:
        return "Colors.cyan";
      case MaterialColorValueType.deepOrange:
        return "Colors.deepOrange";
      case MaterialColorValueType.deepPurple:
        return "Colors.deepPurple";
      case MaterialColorValueType.green:
        return "Colors.green";
      case MaterialColorValueType.grey:
        return "Colors.grey";
      case MaterialColorValueType.indigo:
        return "Colors.indigo";
      case MaterialColorValueType.lightBlue:
        return "Colors.lightBlue";
      case MaterialColorValueType.lightGreen:
        return "Colors.lightGreen";
      case MaterialColorValueType.lime:
        return "Colors.lime";
      case MaterialColorValueType.orange:
        return "Colors.orange";
      case MaterialColorValueType.pink:
        return "Colors.pink";
      case MaterialColorValueType.purple:
        return "Colors.purple";
      case MaterialColorValueType.red:
        return "Colors.red";
      case MaterialColorValueType.teal:
        return "Colors.teal";
      case MaterialColorValueType.yellow:
        return "Colors.yellow";
    }
  }

  @override
  PropertyModel<MaterialColorValueType?> copyWith({
    final MaterialColorValueType? value,
    final bool? isNullable,
    final bool? isReplaceable,
  }) {
    return MateriaColorProperty(value: value ?? super.value);
  }

  @override
  PropertyModel<MaterialColorValueType?> setResolverProperty() {
    return this;
  }

  @override
  String? valueToJson([MaterialColorValueType? value]) {
    value ??= super.value;
    if (value == null) return null;
    return EnumToString.convertToString(value);
  }

  static MaterialColorValueType? valueFromJson(final String? value) {
    if (value == null) return null;
    return EnumToString.fromString(MaterialColorValueType.values, value);
  }

  factory MateriaColorProperty.fromJson(final Map<String, dynamic> json) {
    return MateriaColorProperty(
      value: MateriaColorProperty.valueFromJson(json["value"] as String?),
      isNullable: json['is-nullable'] as bool?,
      isReplaceable: json['is-replaceable'] as bool?,
    );
  }
}
