import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';

import '../enums/property_enums.dart';
import '../models/property_model.dart';

@immutable
class CrossAxisAlignmentProperty extends PropertyModel<CrossAxisAlignment?> {
  CrossAxisAlignmentProperty({
    final CrossAxisAlignment? value,
    final bool? isNullable,
    final bool? isReplaceable,
  }) {
    super.type = PropertyType.crossAxisAlignment;
    super.value = value;
    super.isNullable = isNullable ?? true;
    super.isReplaceable = isReplaceable ?? false;
  }

  @override
  final List<CrossAxisAlignment> availableValues = CrossAxisAlignment.values;

  @override
  CrossAxisAlignment? resolveValue() {
    return value;
  }

  @override
  String toCode() {
    return value.toString();
  }

  @override
  PropertyModel<CrossAxisAlignment?> copyWith({
    final CrossAxisAlignment? value,
    final bool? isNullable,
    final bool? isReplaceable,
  }) {
    return CrossAxisAlignmentProperty(value: value ?? super.value);
  }

  @override
  String? valueToJson([CrossAxisAlignment? value]) {
    value ??= super.value;
    if (value == null) return null;
    return EnumToString.convertToString(value);
  }

  static CrossAxisAlignment? valueFromJson(final String? value) {
    if (value == null) return null;
    return EnumToString.fromString(CrossAxisAlignment.values, value);
  }

  factory CrossAxisAlignmentProperty.fromJson(final Map<String, dynamic> json) {
    return CrossAxisAlignmentProperty(
      value: CrossAxisAlignmentProperty.valueFromJson(json["value"] as String?),
      isNullable: json['is-nullable'] as bool?,
      isReplaceable: json['is-replaceable'] as bool?,
    );
  }
}
