import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';

import '../enums/property_enums.dart';
import '../models/property_model.dart';

enum MaterialAccentColorValueType {
  amberAccent,
  blueAccent,
  cyanAccent,
  deepOrangeAccent,
  deepPurpleAccent,
  greenAccent,
  indigoAccent,
  lightBlueAccent,
  lightGreenAccent,
  limeAccent,
  orangeAccent,
  pinkAccent,
  purpleAccent,
  redAccent,
  tealAccent,
  yellowAccent,
}

@immutable
class MaterialAccentColorProperty
    extends PropertyModel<MaterialAccentColorValueType?> {
  MaterialAccentColorProperty({
    final MaterialAccentColorValueType? value,
    final bool? isNullable,
    final bool? isReplaceable,
  }) {
    super.type = PropertyType.materialAccentColor;
    super.value = value;
    super.isNullable = isNullable ?? true;
    super.isReplaceable = isReplaceable ?? false;
    super.resolverProperties = const {};
  }

  @override
  final List<MaterialAccentColorValueType> availableValues =
      MaterialAccentColorValueType.values;

  @override
  Color? resolveValue() {
    if (value == null) return null;
    switch (value!) {
      case MaterialAccentColorValueType.amberAccent:
        return Colors.amberAccent;
      case MaterialAccentColorValueType.blueAccent:
        return Colors.blueAccent;
      case MaterialAccentColorValueType.cyanAccent:
        return Colors.cyanAccent;
      case MaterialAccentColorValueType.deepOrangeAccent:
        return Colors.deepOrangeAccent;
      case MaterialAccentColorValueType.deepPurpleAccent:
        return Colors.deepPurpleAccent;
      case MaterialAccentColorValueType.greenAccent:
        return Colors.greenAccent;
      case MaterialAccentColorValueType.indigoAccent:
        return Colors.indigoAccent;
      case MaterialAccentColorValueType.lightBlueAccent:
        return Colors.lightBlueAccent;
      case MaterialAccentColorValueType.lightGreenAccent:
        return Colors.lightGreenAccent;
      case MaterialAccentColorValueType.limeAccent:
        return Colors.limeAccent;
      case MaterialAccentColorValueType.orangeAccent:
        return Colors.orangeAccent;
      case MaterialAccentColorValueType.pinkAccent:
        return Colors.pinkAccent;
      case MaterialAccentColorValueType.purpleAccent:
        return Colors.purpleAccent;
      case MaterialAccentColorValueType.redAccent:
        return Colors.redAccent;
      case MaterialAccentColorValueType.tealAccent:
        return Colors.tealAccent;
      case MaterialAccentColorValueType.yellowAccent:
        return Colors.yellowAccent;
    }
  }

  @override
  String toCode() {
    if (value == null) return "null";
    switch (value!) {
      case MaterialAccentColorValueType.amberAccent:
        return "Colors.amberAccent";
      case MaterialAccentColorValueType.blueAccent:
        return "Colors.blueAccent";
      case MaterialAccentColorValueType.cyanAccent:
        return "Colors.cyanAccent";
      case MaterialAccentColorValueType.deepOrangeAccent:
        return "Colors.deepOrangeAccent";
      case MaterialAccentColorValueType.deepPurpleAccent:
        return "Colors.deepPurpleAccent";
      case MaterialAccentColorValueType.greenAccent:
        return "Colors.greenAccent";
      case MaterialAccentColorValueType.indigoAccent:
        return "Colors.indigoAccent";
      case MaterialAccentColorValueType.lightBlueAccent:
        return "Colors.lightBlueAccent";
      case MaterialAccentColorValueType.lightGreenAccent:
        return "Colors.lightGreenAccent";
      case MaterialAccentColorValueType.limeAccent:
        return "Colors.limeAccent";
      case MaterialAccentColorValueType.orangeAccent:
        return "Colors.orangeAccent";
      case MaterialAccentColorValueType.pinkAccent:
        return "Colors.pinkAccent";
      case MaterialAccentColorValueType.purpleAccent:
        return "Colors.purpleAccent";
      case MaterialAccentColorValueType.redAccent:
        return "Colors.redAccent";
      case MaterialAccentColorValueType.tealAccent:
        return "Colors.tealAccent";
      case MaterialAccentColorValueType.yellowAccent:
        return "Colors.yellowAccent";
    }
  }

  @override
  PropertyModel<MaterialAccentColorValueType?> setResolverProperty() {
    return this;
  }

  @override
  PropertyModel<MaterialAccentColorValueType?> copyWith({
    final MaterialAccentColorValueType? value,
    final bool? isNullable,
    final bool? isReplaceable,
  }) {
    return MaterialAccentColorProperty(value: value ?? super.value);
  }

  @override
  String? valueToJson([MaterialAccentColorValueType? value]) {
    value ??= super.value;
    if (value == null) return null;
    return EnumToString.convertToString(value);
  }

  static MaterialAccentColorValueType? valueFromJson(final String? value) {
    if (value == null) return null;
    return EnumToString.fromString(MaterialAccentColorValueType.values, value);
  }

  factory MaterialAccentColorProperty.fromJson(
      final Map<String, dynamic> json) {
    return MaterialAccentColorProperty(
      value:
          MaterialAccentColorProperty.valueFromJson(json["value"] as String?),
      isNullable: json['is-nullable'] as bool?,
      isReplaceable: json['is-replaceable'] as bool?,
    );
  }
}
