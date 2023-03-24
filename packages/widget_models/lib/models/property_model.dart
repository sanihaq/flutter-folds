import 'package:enum_to_string/enum_to_string.dart';

import '../enums/property_enums.dart';
import '../extensions/property_extension.dart';

abstract class PropertyModel<T> {
  late final T? value;

  late final PropertyType type;

  late final bool isNullable;

  late final bool isReplaceable;

  final List<T> availableValues = const [];

  Object? resolveValue();

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
    };
  }

  Object? valueToJson([final T? value]);

  // ignore: strict_raw_type
  static PropertyModel fromJson(final Map<String, dynamic> json) {
    final type = json["type"] as String?;
    if (type == null) throw Error();
    final model =
        EnumToString.fromString<PropertyType>(PropertyType.values, type);
    if (model == null) throw Error();

    return model.fromJson(json);
  }
}
