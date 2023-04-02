import 'package:enum_to_string/enum_to_string.dart';

import '../enums/property_enums.dart';
import '../extensions/property_extension.dart';

abstract class PropertyModel<T> {
  late final T? value;

  final T? defaultValue = null;

  late final Map<String, PropertyModel> resolverProperties;

  late final PropertyType type;

  late final bool isNullable;

  late final bool isReplaceable;

  final List<T> availableValues = const [];

  PropertyModel<T> setValue(final T? value) {
    return copyWith(value: value).setResolverProperty();
  }

  Object? resolveValue();

  PropertyModel<T> setResolverProperty();

  String toCode();

  PropertyModel<T> copyWith({
    final T? value,
    final bool? isNullable,
    final bool? isReplaceable,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'value': valueToJson(),
      'type': EnumToString.convertToString(type),
      if (!isNullable) 'is-nullable': isNullable,
      if (isReplaceable) 'is-replaceable': isReplaceable,
      if (resolverProperties.isNotEmpty)
        "resolver-property": resolverProperties
            .map((final key, final value) => MapEntry(key, value.toJson()))
    };
  }

  Object? valueToJson([final T? value]);

  static PropertyModel fromJson(final Map<String, dynamic> json) {
    final type = json["type"] as String?;
    if (type == null) throw Error();
    final model =
        EnumToString.fromString<PropertyType>(PropertyType.values, type);
    if (model == null) throw Error();

    return model.fromJson(json);
  }
}
