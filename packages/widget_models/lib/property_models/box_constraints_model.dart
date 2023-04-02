import 'package:flutter/widgets.dart';

import '../enums/property_enums.dart';
import '../models/property_model.dart';

@immutable
class BoxConstraintsProperty extends PropertyModel<BoxConstraints?> {
  BoxConstraintsProperty({
    final BoxConstraints? value,
    final bool? isNullable,
    final bool? isReplaceable,
  }) {
    super.type = PropertyType.boxConstraints;
    super.value = value;
    super.isNullable = isNullable ?? true;
    super.isReplaceable = isReplaceable ?? false;
    super.resolverProperties = const {};
  }

  @override
  BoxConstraints? resolveValue() {
    return value;
  }

  @override
  String toCode() {
    return "$value";
  }

  @override
  PropertyModel<BoxConstraints?> copyWith({
    final BoxConstraints? value,
    final bool? isNullable,
    final bool? isReplaceable,
  }) {
    return BoxConstraintsProperty(
      value: value ?? super.value,
    );
  }

  @override
  PropertyModel<BoxConstraints?> setResolverProperty() {
    return this;
  }

  @override
  BoxConstraints? valueToJson([BoxConstraints? value]) {
    value ??= super.value;
    return value ?? super.value;
  }

  static BoxConstraints? valueFromJson(final BoxConstraints? value) => value;

  factory BoxConstraintsProperty.fromJson(final Map<String, dynamic> json) {
    return BoxConstraintsProperty(
      value: BoxConstraintsProperty.valueFromJson(
          json['value'] as BoxConstraints?),
      isNullable: json['is-nullable'] as bool?,
      isReplaceable: json['is-replaceable'] as bool?,
    );
  }
}
