import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';

import '../enums/property_enums.dart';
import '../models/property_model.dart';

enum Matrix4ValueType {
  columns,
  compose,
  copy,
  diagonal3,
  diagonal3Values,
  fromList,
  identity,
  inverted,
  matrix4,
  outer,
  rotationX,
  rotationY,
  rotationZ,
  skew,
  skewX,
  skewY,
  translation,
  translationValues,
  zero,
}

@immutable
class Matrix4Property extends PropertyModel<Matrix4ValueType?> {
  Matrix4Property({
    final Matrix4ValueType? value,
    final bool? isNullable,
    final bool? isReplaceable,
  }) {
    super.type = PropertyType.matrix4;
    super.value = value;
    super.isNullable = isNullable ?? true;
    super.isReplaceable = isReplaceable ?? false;
  }

  @override
  // ignore: overridden_fields
  final List<Matrix4ValueType> availableValues = Matrix4ValueType.values;

  @override
  Matrix4? resolveValue() {
    if (value == null) return null;
    switch (value!) {
      
    }
  }

  @override
  String toCode() {
    if (value == null) return "null";
    switch (value!) {
      
    }
    return "";
  }

  @override
  PropertyModel<Matrix4ValueType?> copyWith({
    final Matrix4ValueType? value,
    final bool? isNullable,
    final bool? isReplaceable,
  }) {
    return Matrix4Property(value: value ?? super.value);
  }

  @override
  String? valueToJson([Matrix4ValueType? value]) {
    value ??= super.value;
    if (value == null) return null;
    return EnumToString.convertToString(value);
  }

  static Matrix4ValueType? valueFromJson(final String? value) {
    if (value == null) return null;
    return EnumToString.fromString(Matrix4ValueType.values, value);
  }

  factory Matrix4Property.fromJson(final Map<String, dynamic> json) {
    return Matrix4Property(
      value: Matrix4Property.valueFromJson(json["value"] as String?),
      isNullable: json['is-nullable'] as bool?,
      isReplaceable: json['is-replaceable'] as bool?,
    );
  }
}
