import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';

import '../enums/property_enums.dart';
import '../models/property_model.dart';

@immutable
class TextDirectionProperty extends PropertyModel<TextDirection?> {
  TextDirectionProperty({
    final TextDirection? value,
    final bool? isNullable,
    final bool? isReplaceable,
  }) {
    super.type = PropertyType.textDirection;
    super.value = value;
    super.isNullable = isNullable ?? true;
    super.isReplaceable = isReplaceable ?? false;
  }

  @override
  // ignore: overridden_fields
  final List<TextDirection> availableValues = TextDirection.values;

  @override
  TextDirection? resolveValue() {
    return value;
  }

  @override
  String toCode() {
    return value.toString();
  }

  @override
  PropertyModel<TextDirection?> copyWith({
    final TextDirection? value,
    final bool? isNullable,
    final bool? isReplaceable,
  }) {
    return TextDirectionProperty(value: value ?? super.value);
  }

  @override
  String? valueToJson([TextDirection? value]) {
    value ??= super.value;
    if (value == null) return null;
    return EnumToString.convertToString(value);
  }

  static TextDirection? valueFromJson(final String? value) {
    if (value == null) return null;
    return EnumToString.fromString(TextDirection.values, value);
  }

  factory TextDirectionProperty.fromJson(final Map<String, dynamic> json) {
    return TextDirectionProperty(
      value: TextDirectionProperty.valueFromJson(json["value"] as String?),
      isNullable: json['is-nullable'] as bool?,
      isReplaceable: json['is-replaceable'] as bool?,
    );
  }
}
