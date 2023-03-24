import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';

import '../enums/property_enums.dart';
import '../models/property_model.dart';

@immutable
class TextBaselineProperty extends PropertyModel<TextBaseline?> {
  TextBaselineProperty({
    final TextBaseline? value,
    final bool? isNullable,
    final bool? isReplaceable,
  }) {
    super.type = PropertyType.textBaseline;
    super.value = value;
    super.isNullable = isNullable ?? true;
    super.isReplaceable = isReplaceable ?? false;
  }

  @override
  // ignore: overridden_fields
  final List<TextBaseline> availableValues = TextBaseline.values;

  @override
  TextBaseline? resolveValue() {
    return value;
  }

  @override
  String toCode() {
    return value.toString();
  }

  @override
  PropertyModel<TextBaseline?> copyWith({
    final TextBaseline? value,
    final bool? isNullable,
    final bool? isReplaceable,
  }) {
    return TextBaselineProperty(value: value ?? super.value);
  }

  @override
  String? valueToJson([TextBaseline? value]) {
    value ??= super.value;
    if (value == null) return null;
    return EnumToString.convertToString(value);
  }

  static TextBaseline? valueFromJson(final String? value) {
    if (value == null) return null;
    return EnumToString.fromString(TextBaseline.values, value);
  }

  factory TextBaselineProperty.fromJson(final Map<String, dynamic> json) {
    return TextBaselineProperty(
      value: TextBaselineProperty.valueFromJson(json["value"] as String?),
      isNullable: json['is-nullable'] as bool?,
      isReplaceable: json['is-replaceable'] as bool?,
    );
  }
}
