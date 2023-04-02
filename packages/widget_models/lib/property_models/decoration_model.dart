import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';

import '../enums/property_enums.dart';
import '../models/property_model.dart';

enum DecorationValueType {
  boxDecoration,
}

@immutable
class DecorationProperty extends PropertyModel<DecorationValueType?> {
  DecorationProperty({
    final DecorationValueType? value,
    final bool? isNullable,
    final bool? isReplaceable,
  }) {
    super.type = PropertyType.decoration;
    super.value = value;
    super.isNullable = isNullable ?? true;
    super.isReplaceable = isReplaceable ?? false;
    super.resolverProperties = const {};
  }

  @override
  final List<DecorationValueType> availableValues = DecorationValueType.values;

  @override
  Decoration? resolveValue() {
    if (value == null) return null;
    switch (value!) {
      
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
  PropertyModel<DecorationValueType?> setResolverProperty() {
    return this;
  }

  @override
  PropertyModel<DecorationValueType?> copyWith({
    final DecorationValueType? value,
    final bool? isNullable,
    final bool? isReplaceable,
  }) {
    return DecorationProperty(value: value ?? super.value);
  }

  @override
  String? valueToJson([DecorationValueType? value]) {
    value ??= super.value;
    if (value == null) return null;
    return EnumToString.convertToString(value);
  }

  static DecorationValueType? valueFromJson(final String? value) {
    if (value == null) return null;
    return EnumToString.fromString(DecorationValueType.values, value);
  }

  factory DecorationProperty.fromJson(final Map<String, dynamic> json) {
    return DecorationProperty(
      value: DecorationProperty.valueFromJson(json["value"] as String?),
      isNullable: json['is-nullable'] as bool?,
      isReplaceable: json['is-replaceable'] as bool?,
    );
  }
}
