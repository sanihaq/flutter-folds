import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';

import '../enums/property_enums.dart';
import '../models/property_model.dart';

enum _KeyValueType {
  global,
  // object,
  unique,
  // value,
}

@immutable
class KeyProperty extends PropertyModel<_KeyValueType?> {
  KeyProperty({
    final _KeyValueType? value,
    final bool? isNullable,
    final bool? isReplaceable,
  }) {
    super.type = PropertyType.key;
    super.value = value;
    super.isNullable = isNullable ?? true;
    super.isReplaceable = isReplaceable ?? false;
  }

  @override
  // ignore: overridden_fields
  final List<_KeyValueType?> availableValues = _KeyValueType.values;

  @override
  Key? resolveValue() {
    if (value == null) return null;
    switch (value!) {
      case _KeyValueType.global:
        return GlobalKey();
      // case _KeyValueType.object:
      //   return const ObjectKey(null);
      case _KeyValueType.unique:
        return UniqueKey();
      // case _KeyValueType.value:
      //   return const ValueKey(null);
    }
  }

  @override
  String toCode() {
    if (value == null) return "null";
    switch (value!) {
      case _KeyValueType.global:
        return "GlobalKey()";
      // case _KeyValueType.object:
      //   return const ObjectKey(null);
      case _KeyValueType.unique:
        return "UniqueKey()";
      // case _KeyValueType.value:
      //   return const ValueKey(null);
    }
  }

  @override
  PropertyModel<_KeyValueType?> copyWith({
    final _KeyValueType? value,
    final bool? isNullable,
    final bool? isReplaceable,
  }) {
    return KeyProperty(value: value ?? super.value);
  }

  @override
  String? valueToJson([final _KeyValueType? value]) {
    if (value == null) return null;
    return EnumToString.convertToString(value);
  }

  static _KeyValueType? valueFromJson(final String? value) {
    if (value == null) return null;
    return EnumToString.fromString(_KeyValueType.values, value);
  }

  factory KeyProperty.fromJson(final Map<String, dynamic> json) {
    return KeyProperty(
      value: KeyProperty.valueFromJson(json["value"] as String?),
      isNullable: json['value'] as bool?,
      isReplaceable: json['value'] as bool?,
    );
  }
}
