import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widget_models/enums/child_enums.dart';
import 'package:widget_models/enums/model_enums.dart';
import 'package:widget_models/models/child_model.dart';
import 'package:widget_models/property_models/key_model.dart';
import 'package:widget_models/widget_models/widgets/center_model.dart';
import 'package:widget_models/widget_models/widgets/column_model.dart';

void main() {
  test("Column model with no value test", () {
    final model = ColumnModel(id: "7727R8");

    expect(ModelType.column, model.type);
    expect(Column, model.toWidget().runtimeType);
    expect("Column()", model.toCode());
    expect({
      "id": "7727R8",
      "type": "column",
      "properties": <String, dynamic>{},
      "children": <String, dynamic>{}
    }, model.toJson());
  });

  const Map<String, dynamic> sampleModelData = <String, dynamic>{
    "id": "7727R8",
    "type": "column",
    "properties": {
      "key": {"value": "unique", "type": "key"}
    },
    "children": {
      "children": {
        "type": "children",
        "children": [
          {
            "id": "35277C",
            "type": "center",
            "properties": <String, dynamic>{},
            "children": <String, dynamic>{}
          },
          {
            "id": "35277D",
            "type": "center",
            "properties": <String, dynamic>{},
            "children": <String, dynamic>{}
          }
        ]
      }
    }
  };

  test("column model with value test", () {
    final model = ColumnModel(
      id: "7727R8",
      properties: {
        "key": KeyProperty(
          value: KeyValueType.unique,
        )
      },
      children: {
        "children": ChildModel(
          type: ChildType.children,
          children: [
            CenterModel(id: "35277C"),
            CenterModel(id: "35277D"),
          ],
        )
      },
    );

    expect(ModelType.column, model.type);
    expect(Column, model.toWidget().runtimeType);
    expect("Column(key:UniqueKey(),children:[Center(),Center()],)",
        model.toCode());

    expect(sampleModelData, model.toJson());
  });

  test("column model from json", () {
    final model = ColumnModel.fromJson(sampleModelData);

    expect(1, model.properties.length);
    expect(2, model.children["children"]?.children.length);
    expect(Column, model.toWidget().runtimeType);
  });
}
