import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';

import '../enums/property_enums.dart';
import '../models/property_model.dart';

@immutable
class MainAxisSizeProperty extends PropertyModel<MainAxisSize?> {
  MainAxisSizeProperty({
    final MainAxisSize? value,
    final bool? isNullable,
    final bool? isReplaceable,
  }) {
    super.type = PropertyType.mainAxisSize;
    super.value = value;
    super.isNullable = isNullable ?? true;
    super.isReplaceable = isReplaceable ?? false;
  }

  @override
  final List<MainAxisSize> availableValues = MainAxisSize.values;

  @override
  MainAxisSize? resolveValue() {
    return value;
  }

  @override
  String toCode() {
    return value.toString();
  }

  @override
  PropertyModel<MainAxisSize?> copyWith({
    final MainAxisSize? value,
    final bool? isNullable,
    final bool? isReplaceable,
  }) {
    return MainAxisSizeProperty(value: value ?? super.value);
  }

  @override
  String? valueToJson([MainAxisSize? value]) {
    value ??= super.value;
    if (value == null) return null;
    return EnumToString.convertToString(value);
  }

  static MainAxisSize? valueFromJson(final String? value) {
    if (value == null) return null;
    return EnumToString.fromString(MainAxisSize.values, value);
  }

  factory MainAxisSizeProperty.fromJson(final Map<String, dynamic> json) {
    return MainAxisSizeProperty(
      value: MainAxisSizeProperty.valueFromJson(json["value"] as String?),
      isNullable: json['is-nullable'] as bool?,
      isReplaceable: json['is-replaceable'] as bool?,
    );
  }
}
