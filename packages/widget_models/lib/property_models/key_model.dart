import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';

import '../enums/property_enums.dart';
import '../models/property_model.dart';

enum KeyValueType {
  global,
  // object,
  unique,
  // value,
}

@immutable
class KeyProperty extends PropertyModel<KeyValueType?> {
  KeyProperty({
    final KeyValueType? value,
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
  final List<KeyValueType> availableValues = KeyValueType.values;

  @override
  Key? resolveValue() {
    if (value == null) return null;
    switch (value!) {
      case KeyValueType.global:
        return GlobalKey();
      // case KeyValueType.object:
      //   return const ObjectKey(null);
      case KeyValueType.unique:
        return UniqueKey();
      // case KeyValueType.value:
      //   return const ValueKey(null);
    }
  }

  @override
  String toCode() {
    if (value == null) return "null";
    switch (value!) {
      case KeyValueType.global:
        return "GlobalKey()";
      // case KeyValueType.object:
      //   return const ObjectKey(null);
      case KeyValueType.unique:
        return "UniqueKey()";
      // case KeyValueType.value:
      //   return const ValueKey(null);
    }
  }

  @override
  PropertyModel<KeyValueType?> copyWith({
    final KeyValueType? value,
    final bool? isNullable,
    final bool? isReplaceable,
  }) {
    return KeyProperty(value: value ?? super.value);
  }

  @override
  String? valueToJson([KeyValueType? value]) {
    value ??= super.value;
    if (value == null) return null;
    return EnumToString.convertToString(value);
  }

  static KeyValueType? valueFromJson(final String? value) {
    if (value == null) return null;
    return EnumToString.fromString(KeyValueType.values, value);
  }

  factory KeyProperty.fromJson(final Map<String, dynamic> json) {
    return KeyProperty(
      value: KeyProperty.valueFromJson(json["value"] as String?),
      isNullable: json['is-nullable'] as bool?,
      isReplaceable: json['is-replaceable'] as bool?,
    );
  }
}
