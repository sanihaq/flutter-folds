import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';

import '../enums/property_enums.dart';
import '../models/property_model.dart';

@immutable
class ClipProperty extends PropertyModel<Clip?> {
  ClipProperty({
    final Clip? value,
    final bool? isNullable,
    final bool? isReplaceable,
  }) {
    super.type = PropertyType.clip;
    super.value = value;
    super.isNullable = isNullable ?? true;
    super.isReplaceable = isReplaceable ?? false;
  }

  @override
  final List<Clip> availableValues = Clip.values;

  @override
  Clip? resolveValue() {
    return value;
  }

  @override
  String toCode() {
    return value.toString();
  }

  @override
  PropertyModel<Clip?> copyWith({
    final Clip? value,
    final bool? isNullable,
    final bool? isReplaceable,
  }) {
    return ClipProperty(value: value ?? super.value);
  }

  @override
  String? valueToJson([Clip? value]) {
    value ??= super.value;
    if (value == null) return null;
    return EnumToString.convertToString(value);
  }

  static Clip? valueFromJson(final String? value) {
    if (value == null) return null;
    return EnumToString.fromString(Clip.values, value);
  }

  factory ClipProperty.fromJson(final Map<String, dynamic> json) {
    return ClipProperty(
      value: ClipProperty.valueFromJson(json["value"] as String?),
      isNullable: json['is-nullable'] as bool?,
      isReplaceable: json['is-replaceable'] as bool?,
    );
  }
}
