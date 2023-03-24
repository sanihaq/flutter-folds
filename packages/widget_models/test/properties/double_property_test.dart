import 'package:flutter_test/flutter_test.dart';
import 'package:widget_models/enums/property_enums.dart';
import 'package:widget_models/property_models/double.dart';

void main() {
  test('double property with no value test', () {
    final model = DoubleProperty();
    expect(null, model.resolveValue());
    expect("null", model.toCode());
  });
  test('double property with value test', () {
    final model = DoubleProperty(value: 1);
    expect(1.0, model.resolveValue());
    expect("1.0", model.toCode());
  });

  test('double property to json with no value', () {
    final model = DoubleProperty();
    expect({"value": null, "type": "double"}, model.toJson());
  });
  test('double property to json with value', () {
    final model = DoubleProperty(value: 1);
    expect({"value": 1.0, "type": "double"}, model.toJson());
  });

  test('double property from json ', () {
    final model = DoubleProperty.fromJson(
        <String, dynamic>{"value": 1.0, "type": "double"});
    expect(1.0, model.value);
    expect(PropertyType.double, model.type);
  });
}
