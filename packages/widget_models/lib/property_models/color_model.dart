import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';

import '../enums/property_enums.dart';
import '../models/property_model.dart';

enum ColorValueType {
  color,
  materialColor,
}

@immutable
class ColorProperty extends PropertyModel<ColorValueType?> {
  ColorProperty({
    final ColorValueType? value,
    final bool? isNullable,
    final bool? isReplaceable,
  }) {
    super.type = PropertyType.color;
    super.value = value;
    super.isNullable = isNullable ?? true;
    super.isReplaceable = isReplaceable ?? false;
  }

  @override
  final List<ColorValueType> availableValues = ColorValueType.values;

  @override
  Color? resolveValue() {
    if (value == null) return null;
    switch (value!) {
      case ColorValueType.color:
        // TODO: Handle this case.
        break;
      case ColorValueType.materialColor:
        // TODO: Handle this case.
        break;
    }
  }

  @override
  String toCode() {
    if (value == null) return "null";
    switch (value!) {
      
    }
    return "";
  }

  @override
  PropertyModel<ColorValueType?> copyWith({
    final ColorValueType? value,
    final bool? isNullable,
    final bool? isReplaceable,
  }) {
    return ColorProperty(value: value ?? super.value);
  }

  @override
  String? valueToJson([ColorValueType? value]) {
    value ??= super.value;
    if (value == null) return null;
    return EnumToString.convertToString(value);
  }

  static ColorValueType? valueFromJson(final String? value) {
    if (value == null) return null;
    return EnumToString.fromString(ColorValueType.values, value);
  }

  factory ColorProperty.fromJson(final Map<String, dynamic> json) {
    return ColorProperty(
      value: ColorProperty.valueFromJson(json["value"] as String?),
      isNullable: json['is-nullable'] as bool?,
      isReplaceable: json['is-replaceable'] as bool?,
    );
  }
}
