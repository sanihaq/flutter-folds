import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';

import '../enums/property_enums.dart';
import '../models/property_model.dart';

@immutable
class VerticalDirectionProperty extends PropertyModel<VerticalDirection?> {
  VerticalDirectionProperty({
    final VerticalDirection? value,
    final bool? isNullable,
    final bool? isReplaceable,
  }) {
    super.type = PropertyType.verticalDirection;
    super.value = value;
    super.isNullable = isNullable ?? true;
    super.isReplaceable = isReplaceable ?? false;
  }

  @override
  final List<VerticalDirection> availableValues = VerticalDirection.values;

  @override
  VerticalDirection? resolveValue() {
    return value;
  }

  @override
  String toCode() {
    return value.toString();
  }

  @override
  PropertyModel<VerticalDirection?> copyWith({
    final VerticalDirection? value,
    final bool? isNullable,
    final bool? isReplaceable,
  }) {
    return VerticalDirectionProperty(value: value ?? super.value);
  }

  @override
  String? valueToJson([VerticalDirection? value]) {
    value ??= super.value;
    if (value == null) return null;
    return EnumToString.convertToString(value);
  }

  static VerticalDirection? valueFromJson(final String? value) {
    if (value == null) return null;
    return EnumToString.fromString(VerticalDirection.values, value);
  }

  factory VerticalDirectionProperty.fromJson(final Map<String, dynamic> json) {
    return VerticalDirectionProperty(
      value: VerticalDirectionProperty.valueFromJson(json["value"] as String?),
      isNullable: json['is-nullable'] as bool?,
      isReplaceable: json['is-replaceable'] as bool?,
    );
  }
}
