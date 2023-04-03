import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';

import '../enums/property_enums.dart';
import '../models/property_model.dart';
import '../extensions/property_extension.dart';
import 'material_accent_color_model.dart';
import 'material_color_model.dart';
import 'raw_color_model.dart';

enum ColorValueType {
  color,
  materialColor,
  materialAccentColor,
  black,
  black12,
  black26,
  black38,
  black45,
  black54,
  black87,
  transparent,
  white,
  white10,
  white12,
  white24,
  white30,
  white38,
  white54,
  white60,
  white70,
}

@immutable
class ColorProperty extends PropertyModel<ColorValueType?> {
  ColorProperty({
    final ColorValueType? value,
    final bool? isNullable,
    final bool? isReplaceable,
    final Map<String, PropertyModel>? resolverProperties,
  }) {
    super.type = PropertyType.color;
    super.value = value;
    super.isNullable = isNullable ?? true;
    super.isReplaceable = isReplaceable ?? false;
    super.resolverProperties = resolverProperties ?? const {};
  }

  @override
  final List<ColorValueType> availableValues = ColorValueType.values;

  @override
  PropertyModel<ColorValueType?> setResolverProperty() {
    if (value == ColorValueType.color) {
      return copyWith(resolverProperty: {
        "color": RawColorProperty(
          isNullable: super.isNullable,
          isReplaceable: super.isReplaceable,
        )
      });
    } else if (value == ColorValueType.materialColor) {
      return copyWith(resolverProperty: {
        "materialColor": MateriaColorProperty(
          isNullable: super.isNullable,
          isReplaceable: super.isReplaceable,
        )
      });
    } else if (value == ColorValueType.materialAccentColor) {
      return copyWith(resolverProperty: {
        "materialAccentColor": MaterialAccentColorProperty(
          isNullable: super.isNullable,
          isReplaceable: super.isReplaceable,
        )
      });
    } else {
      return copyWith(resolverProperty: {});
    }
  }

  @override
  Color? resolveValue() {
    if (value == null) return null;
    switch (value!) {
      case ColorValueType.color:
        return (resolverProperties["color"] as RawColorProperty?)
            ?.resolveValue();
      case ColorValueType.materialColor:
        return (resolverProperties["materialColor"] as MateriaColorProperty?)
            ?.resolveValue();
      case ColorValueType.materialAccentColor:
        return (resolverProperties["materialAccentColor"]
                as MaterialAccentColorProperty?)
            ?.resolveValue();
      case ColorValueType.black:
        return Colors.black;
      case ColorValueType.black12:
        return Colors.black12;
      case ColorValueType.black26:
        return Colors.black26;
      case ColorValueType.black38:
        return Colors.black38;
      case ColorValueType.black45:
        return Colors.black45;
      case ColorValueType.black54:
        return Colors.black54;
      case ColorValueType.black87:
        return Colors.black87;
      case ColorValueType.transparent:
        return Colors.transparent;
      case ColorValueType.white:
        return Colors.white;
      case ColorValueType.white10:
        return Colors.white10;
      case ColorValueType.white12:
        return Colors.white12;
      case ColorValueType.white24:
        return Colors.white24;
      case ColorValueType.white30:
        return Colors.white30;
      case ColorValueType.white38:
        return Colors.white38;
      case ColorValueType.white54:
        return Colors.white54;
      case ColorValueType.white60:
        return Colors.white60;
      case ColorValueType.white70:
        return Colors.white70;
    }
  }

  @override
  String toCode() {
    if (value == null) return "null";
    switch (value!) {
      case ColorValueType.color:
        return (resolverProperties["color"] as RawColorProperty?)?.toCode() ??
            "null";
      case ColorValueType.materialColor:
        return (resolverProperties["materialColor"] as MateriaColorProperty?)
                ?.toCode() ??
            "null";
      case ColorValueType.materialAccentColor:
        return (resolverProperties["materialAccentColor"]
                    as MaterialAccentColorProperty?)
                ?.toCode() ??
            "null";
      case ColorValueType.black:
        return "Colors.black";
      case ColorValueType.black12:
        return "Colors.black12";
      case ColorValueType.black26:
        return "Colors.black26";
      case ColorValueType.black38:
        return "Colors.black38";
      case ColorValueType.black45:
        return "Colors.black45";
      case ColorValueType.black54:
        return "Colors.black54";
      case ColorValueType.black87:
        return "Colors.black87";
      case ColorValueType.transparent:
        return "Colors.transparent";
      case ColorValueType.white:
        return "Colors.white";
      case ColorValueType.white10:
        return "Colors.white10";
      case ColorValueType.white12:
        return "Colors.white12";
      case ColorValueType.white24:
        return "Colors.white24";
      case ColorValueType.white30:
        return "Colors.white30";
      case ColorValueType.white38:
        return "Colors.white38";
      case ColorValueType.white54:
        return "Colors.white54";
      case ColorValueType.white60:
        return "Colors.white60";
      case ColorValueType.white70:
        return "Colors.white70";
    }
  }

  @override
  PropertyModel<ColorValueType?> copyWith({
    final ColorValueType? value,
    final bool? isNullable,
    final bool? isReplaceable,
    final Map<String, PropertyModel>? resolverProperty,
  }) {
    return ColorProperty(
      value: value ?? super.value,
      resolverProperties: resolverProperty ?? super.resolverProperties,
    );
  }

  @override
  String? valueToJson([ColorValueType? value]) {
    value ??= super.value;
    if (value == null) return null;
    return EnumToString.convertToString(value);
  }

  static ColorValueType? valueFromJson(final String? value) {
    if (value == null) return null;
    return EnumToString.fromString(ColorValueType.values, value);
  }

  factory ColorProperty.fromJson(final Map<String, dynamic> json) {
    final resolverPropertyData = json.containsKey("resolver-property")
        ? Map<String, Map<String, dynamic>>.from(
            json["resolver-property"] as Map)
        : null;
    final _resolverProperties =
        resolverPropertyData?.map<String, PropertyModel>(
      (final key, final value) {
        final String typeString = value["type"] as String;
        return MapEntry<String, PropertyModel>(
          key,
          EnumToString.fromString<PropertyType>(
                  PropertyType.values, typeString)!
              .fromJson(value),
        );
      },
    );
    return ColorProperty(
      value: ColorProperty.valueFromJson(json["value"] as String?),
      isNullable: json['is-nullable'] as bool?,
      isReplaceable: json['is-replaceable'] as bool?,
      resolverProperties: _resolverProperties,
    );
  }
}
