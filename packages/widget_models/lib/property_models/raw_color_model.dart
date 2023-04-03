import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';

import '../enums/property_enums.dart';
import '../models/property_model.dart';

@immutable
class RawColorProperty extends PropertyModel<Color?> {
  RawColorProperty({
    final Color? value,
    final bool? isNullable,
    final bool? isReplaceable,
    final Map<String, PropertyModel>? resolverProperties,
  }) {
    super.type = PropertyType.rawColor;
    super.value = value;
    super.isNullable = isNullable ?? true;
    super.isReplaceable = isReplaceable ?? false;
    super.resolverProperties = resolverProperties ?? const {};
  }

  @override
  PropertyModel<Color?> setResolverProperty() {
    return this;
  }

  @override
  Color? resolveValue() {
    if (value == null) return null;
    return value;
  }

  @override
  String toCode() {
    if (value == null) return "null";
    return value.toString();
  }

  @override
  PropertyModel<Color?> copyWith({
    final Color? value,
    final bool? isNullable,
    final bool? isReplaceable,
    final Map<String, PropertyModel>? resolverProperty,
  }) {
    return RawColorProperty(
      value: value ?? super.value,
      resolverProperties: resolverProperty ?? super.resolverProperties,
    );
  }

  @override
  String? valueToJson([Color? value]) {
    value ??= super.value;
    if (value == null) return null;
    return value.value.toString();
  }

  static Color? valueFromJson(final String? value) {
    if (value == null) return null;
    final _value = int.tryParse(value);
    return _value != null ? Color(_value) : null;
  }

  factory RawColorProperty.fromJson(final Map<String, dynamic> json) {
    return RawColorProperty(
      value: RawColorProperty.valueFromJson(json["value"] as String?),
      isNullable: json['is-nullable'] as bool?,
      isReplaceable: json['is-replaceable'] as bool?,
    );
  }
}
