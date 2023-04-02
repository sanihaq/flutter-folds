import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';

import '../enums/property_enums.dart';
import '../models/property_model.dart';

enum AlignmentValueType {
  bottomCenter,
  bottomLeft,
  bottomRight,
  center,
  centerLeft,
  centerRight,
  topCenter,
  topLeft,
  topRight,
}

@immutable
class AlignmentProperty extends PropertyModel<AlignmentValueType?> {
  AlignmentProperty({
    final AlignmentValueType? value,
    final bool? isNullable,
    final bool? isReplaceable,
  }) {
    super.type = PropertyType.alignment;
    super.value = value;
    super.isNullable = isNullable ?? true;
    super.isReplaceable = isReplaceable ?? false;
    super.resolverProperties = const {};
  }

  @override
  final List<AlignmentValueType> availableValues = AlignmentValueType.values;

  @override
  Alignment? resolveValue() {
    if (value == null) return null;
    switch (value!) {
      case AlignmentValueType.bottomCenter:
        return Alignment.bottomCenter;
      case AlignmentValueType.bottomLeft:
        return Alignment.bottomLeft;
      case AlignmentValueType.bottomRight:
        return Alignment.bottomRight;
      case AlignmentValueType.center:
        return Alignment.center;
      case AlignmentValueType.centerLeft:
        return Alignment.centerLeft;
      case AlignmentValueType.centerRight:
        return Alignment.centerRight;
      case AlignmentValueType.topCenter:
        return Alignment.topCenter;
      case AlignmentValueType.topLeft:
        return Alignment.topLeft;
      case AlignmentValueType.topRight:
        return Alignment.topRight;
    }
  }

  @override
  String toCode() {
    if (value == null) return "null";
    switch (value!) {
      case AlignmentValueType.bottomCenter:
        return "Alignment.bottomCenter";
      case AlignmentValueType.bottomLeft:
        return "Alignment.bottomLeft";
      case AlignmentValueType.bottomRight:
        return "Alignment.bottomRight";
      case AlignmentValueType.center:
        return "Alignment.center";
      case AlignmentValueType.centerLeft:
        return "Alignment.centerLeft";
      case AlignmentValueType.centerRight:
        return "Alignment.centerRight";
      case AlignmentValueType.topCenter:
        return "Alignment.topCenter";
      case AlignmentValueType.topLeft:
        return "Alignment.topLeft";
      case AlignmentValueType.topRight:
        return "Alignment.topRight";
    }
  }

  @override
  PropertyModel<AlignmentValueType?> setResolverProperty() {
    return this;
  }

  @override
  PropertyModel<AlignmentValueType?> copyWith({
    final AlignmentValueType? value,
    final bool? isNullable,
    final bool? isReplaceable,
  }) {
    return AlignmentProperty(value: value ?? super.value);
  }

  @override
  String? valueToJson([AlignmentValueType? value]) {
    value ??= super.value;
    if (value == null) return null;
    return EnumToString.convertToString(value);
  }

  static AlignmentValueType? valueFromJson(final String? value) {
    if (value == null) return null;
    return EnumToString.fromString(AlignmentValueType.values, value);
  }

  factory AlignmentProperty.fromJson(final Map<String, dynamic> json) {
    return AlignmentProperty(
      value: AlignmentProperty.valueFromJson(json["value"] as String?),
      isNullable: json['is-nullable'] as bool?,
      isReplaceable: json['is-replaceable'] as bool?,
    );
  }
}
