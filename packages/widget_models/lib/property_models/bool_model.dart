import 'package:flutter/foundation.dart';

import '../enums/property_enums.dart';
import '../models/property_model.dart';

@immutable
class BoolProperty extends PropertyModel<bool?> {
  BoolProperty({
    final bool? value,
    this.defaultValue,
    final bool? isNullable,
    final bool? isReplaceable,
  }) {
    super.type = PropertyType.bool;
    super.value = value;
    super.isNullable = isNullable ?? true;
    super.isReplaceable = isReplaceable ?? false;
    super.resolverProperties = const {};
  }

  @override
  final bool? defaultValue;

  @override
  bool? resolveValue() {
    return value;
  }

  @override
  String toCode() {
    return "$value";
  }

  @override
  PropertyModel<bool?> copyWith({
    final bool? value,
    final bool? isNullable,
    final bool? isReplaceable,
  }) {
    return BoolProperty(
      value: value ?? super.value,
      isNullable: isNullable ?? super.isNullable,
      isReplaceable: isReplaceable ?? super.isReplaceable,
    );
  }

  @override
  PropertyModel<bool?> setResolverProperty() {
    return this;
  }

  @override
  bool? valueToJson([bool? value]) {
    value ??= super.value;
    return value ?? super.value;
  }

  static bool? valueFromJson(final bool? value) => value;

  factory BoolProperty.fromJson(final Map<String, dynamic> json) {
    return BoolProperty(
      value: BoolProperty.valueFromJson(json['value'] as bool?),
      isNullable: json['is-nullable'] as bool?,
      isReplaceable: json['is-replaceable'] as bool?,
    );
  }
}
