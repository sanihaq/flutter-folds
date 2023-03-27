import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';

import '../enums/property_enums.dart';
import '../models/property_model.dart';

enum EdgeInsetsValueType {
  all,
  fromLTRB,
  fromWindowEdgeInsets,
  only,
  symmetric,
  zero,
}

@immutable
class EdgeInsetsProperty extends PropertyModel<EdgeInsetsValueType?> {
  EdgeInsetsProperty({
    final EdgeInsetsValueType? value,
    final bool? isNullable,
    final bool? isReplaceable,
  }) {
    super.type = PropertyType.edgeInsets;
    super.value = value;
    super.isNullable = isNullable ?? true;
    super.isReplaceable = isReplaceable ?? false;
  }

  @override
  final List<EdgeInsetsValueType> availableValues = EdgeInsetsValueType.values;

  @override
  EdgeInsets? resolveValue() {
    if (value == null) return null;
    switch (value!) {
      case EdgeInsetsValueType.all:
        return EdgeInsets.all(0);
      case EdgeInsetsValueType.fromLTRB:
        return EdgeInsets.all(0);
      case EdgeInsetsValueType.fromWindowEdgeInsets:
        return EdgeInsets.all(0);
      case EdgeInsetsValueType.only:
        return EdgeInsets.all(0);
      case EdgeInsetsValueType.symmetric:
        return EdgeInsets.all(0);
      case EdgeInsetsValueType.zero:
        return EdgeInsets.all(0);
    }
  }

  @override
  String toCode() {
    if (value == null) return "null";
    switch (value!) {
      case EdgeInsetsValueType.all:

      case EdgeInsetsValueType.fromLTRB:

      case EdgeInsetsValueType.fromWindowEdgeInsets:

      case EdgeInsetsValueType.only:

      case EdgeInsetsValueType.symmetric:

      case EdgeInsetsValueType.zero:
    }
    return "";
  }

  @override
  PropertyModel<EdgeInsetsValueType?> copyWith({
    final EdgeInsetsValueType? value,
    final bool? isNullable,
    final bool? isReplaceable,
  }) {
    return EdgeInsetsProperty(value: value ?? super.value);
  }

  @override
  String? valueToJson([EdgeInsetsValueType? value]) {
    value ??= super.value;
    if (value == null) return null;
    return EnumToString.convertToString(value);
  }

  static EdgeInsetsValueType? valueFromJson(final String? value) {
    if (value == null) return null;
    return EnumToString.fromString(EdgeInsetsValueType.values, value);
  }

  factory EdgeInsetsProperty.fromJson(final Map<String, dynamic> json) {
    return EdgeInsetsProperty(
      value: EdgeInsetsProperty.valueFromJson(json["value"] as String?),
      isNullable: json['is-nullable'] as bool?,
      isReplaceable: json['is-replaceable'] as bool?,
    );
  }
}
