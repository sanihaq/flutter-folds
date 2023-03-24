import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';

import '../enums/property_enums.dart';
import '../models/property_model.dart';

@immutable
class MainAxisAlignmentProperty extends PropertyModel<MainAxisAlignment?> {
  MainAxisAlignmentProperty({
    final MainAxisAlignment? value,
    final bool? isNullable,
    final bool? isReplaceable,
  }) {
    super.type = PropertyType.mainAxisAlignment;
    super.value = value;
    super.isNullable = isNullable ?? true;
    super.isReplaceable = isReplaceable ?? false;
  }

  @override
  // ignore: overridden_fields
  final List<MainAxisAlignment> availableValues = MainAxisAlignment.values;

  @override
  MainAxisAlignment? resolveValue() {
    return value;
  }

  @override
  String toCode() {
    return value.toString();
  }

  @override
  PropertyModel<MainAxisAlignment?> copyWith({
    final MainAxisAlignment? value,
    final bool? isNullable,
    final bool? isReplaceable,
  }) {
    return MainAxisAlignmentProperty(value: value ?? super.value);
  }

  @override
  String? valueToJson([MainAxisAlignment? value]) {
    value ??= super.value;
    if (value == null) return null;
    return EnumToString.convertToString(value);
  }

  static MainAxisAlignment? valueFromJson(final String? value) {
    if (value == null) return null;
    return EnumToString.fromString(MainAxisAlignment.values, value);
  }

  factory MainAxisAlignmentProperty.fromJson(final Map<String, dynamic> json) {
    return MainAxisAlignmentProperty(
      value: MainAxisAlignmentProperty.valueFromJson(json["value"] as String?),
      isNullable: json['is-nullable'] as bool?,
      isReplaceable: json['is-replaceable'] as bool?,
    );
  }
}
