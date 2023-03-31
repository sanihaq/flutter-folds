import 'package:flutter/material.dart' hide ColorProperty;
import 'package:widget_models/enums/property_enums.dart';
import 'package:widget_models/models/property_model.dart';
import 'package:widget_models/property_models.dart';

import '../utils/utils.dart';

DropdownButton<T?> _dropDown<T>(final List<T> values, final T? value,
    final bool isNullable, final void Function(T?) onChange) {
  return DropdownButton<T?>(
    isDense: true,
    isExpanded: true,
    value: value,
    items: values.map((final e) {
      return DropdownMenuItem<T?>(
        value: e,
        child: Text(getTitleFromEnum(e.toString())),
      );
    }).toList()
      ..insertAll(0, [
        if (isNullable)
          DropdownMenuItem<T?>(
            value: null,
            child: const Text("null"),
          )
      ]),
    onChanged: onChange,
  );
}

Widget getPropertyInput<T>(final PropertyModel<T> model,
    final void Function(PropertyModel property) onSubmit) {
  switch (model.type) {
    case PropertyType.alignment:
      final _model = model as AlignmentProperty;
      return _dropDown<AlignmentValueType>(
        _model.availableValues,
        _model.value,
        _model.isNullable,
        (final value) {
          onSubmit(_model.copyWith(value: value));
        },
      );
    case PropertyType.bool:
      // TODO: Handle this case.
      break;
    case PropertyType.boxConstraints:
      // TODO: Handle this case.
      break;
    case PropertyType.color:
      final _model = model as ColorProperty;
      return _dropDown<ColorValueType>(
        _model.availableValues,
        _model.value,
        _model.isNullable,
        (final value) {
          onSubmit(_model.copyWith(value: value));
        },
      );
    case PropertyType.clip:
      final _model = model as ClipProperty;
      return _dropDown<Clip>(
        _model.availableValues,
        _model.value,
        _model.isNullable,
        (final value) {
          onSubmit(_model.copyWith(value: value));
        },
      );
    case PropertyType.crossAxisAlignment:
      final _model = model as CrossAxisAlignmentProperty;
      return _dropDown<CrossAxisAlignment>(
        _model.availableValues,
        _model.value,
        _model.isNullable,
        (final value) {
          onSubmit(_model.copyWith(value: value));
        },
      );

    case PropertyType.decoration:
      final _model = model as DecorationProperty;
      return _dropDown<DecorationValueType>(
        _model.availableValues,
        _model.value,
        _model.isNullable,
        (final value) {
          onSubmit(_model.copyWith(value: value));
        },
      );

    case PropertyType.double:
      return TextField(
        inputFormatters: [],
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.only(bottom: 10),
        ),
        onSubmitted: (final value) {
          onSubmit((model as DoubleProperty)
              .copyWith(value: double.tryParse(value)));
        },
      );
    case PropertyType.edgeInsets:
      final _model = model as EdgeInsetsProperty;
      return _dropDown<EdgeInsetsValueType>(
        _model.availableValues,
        _model.value,
        _model.isNullable,
        (final value) {
          onSubmit(_model.copyWith(value: value));
        },
      );

    case PropertyType.fontStyle:
      // TODO: Handle this case.
      break;
    case PropertyType.fontWeight:
      // TODO: Handle this case.
      break;
    case PropertyType.function:
      // TODO: Handle this case.
      break;
    case PropertyType.iconData:
      // TODO: Handle this case.
      break;
    case PropertyType.int:
      // TODO: Handle this case.
      break;
    case PropertyType.key:
      final _model = model as KeyProperty;
      return _dropDown<KeyValueType>(
        _model.availableValues,
        _model.value,
        _model.isNullable,
        (final value) {
          onSubmit(_model.copyWith(value: value));
        },
      );

    case PropertyType.matrix4:
      final _model = model as Matrix4Property;
      return _dropDown<Matrix4ValueType>(
        _model.availableValues,
        _model.value,
        _model.isNullable,
        (final value) {
          onSubmit(_model.copyWith(value: value));
        },
      );
    case PropertyType.mainAxisAlignment:
      final _model = model as MainAxisAlignmentProperty;
      return _dropDown<MainAxisAlignment>(
        _model.availableValues,
        _model.value,
        _model.isNullable,
        (final value) {
          onSubmit(_model.copyWith(value: value));
        },
      );
    case PropertyType.mainAxisSize:
      final _model = model as MainAxisSizeProperty;
      return _dropDown<MainAxisSize>(
        _model.availableValues,
        _model.value,
        _model.isNullable,
        (final value) {
          onSubmit(_model.copyWith(value: value));
        },
      );
    case PropertyType.string:
      // TODO: Handle this case.
      break;
    case PropertyType.textBaseline:
      final _model = model as TextBaselineProperty;
      return _dropDown<TextBaseline>(
        _model.availableValues,
        _model.value,
        _model.isNullable,
        (final value) {
          onSubmit(_model.copyWith(value: value));
        },
      );
    case PropertyType.textDirection:
      final _model = model as TextDirectionProperty;
      return _dropDown<TextDirection>(
        _model.availableValues,
        _model.value,
        _model.isNullable,
        (final value) {
          onSubmit(_model.copyWith(value: value));
        },
      );
    case PropertyType.textStyle:
      // TODO: Handle this case.
      break;
    case PropertyType.verticalDirection:
      final _model = model as VerticalDirectionProperty;
      return _dropDown<VerticalDirection>(
        _model.availableValues,
        _model.value,
        _model.isNullable,
        (final value) {
          onSubmit(_model.copyWith(value: value));
        },
      );
  }
  return SizedBox();
}
