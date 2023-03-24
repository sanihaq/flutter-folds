import 'package:flutter/foundation.dart';

import '../enums/property_enums.dart';
import '../models/property_model.dart';

@immutable
class DoubleProperty extends PropertyModel<double?> {
  DoubleProperty({
    final double? value,
    final bool? isNullable,
    final bool? isReplaceable,
  }) {
    super.type = PropertyType.double;
    super.value = value;
    super.isNullable = isNullable ?? true;
    super.isReplaceable = isReplaceable ?? false;
  }

  @override
  double? resolveValue() {
    return value;
  }

  @override
  String toCode() {
    return "$value";
  }

  @override
  PropertyModel<double?> copyWith({
    final double? value,
    final bool? isNullable,
    final bool? isReplaceable,
  }) {
    return DoubleProperty(
      value: value ?? super.value,
    );
  }

  @override
  double? valueToJson([final double? value]) {
    return value ?? super.value;
  }

  static double? valueFromJson(final double? value) => value;

  factory DoubleProperty.fromJson(final Map<String, dynamic> json) {
    return DoubleProperty(
      value: DoubleProperty.valueFromJson(json['value'] as double?),
      isNullable: json['is-nullable'] as bool?,
      isReplaceable: json['is-replaceable'] as bool?,
    );
  }
}
