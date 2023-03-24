import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widget_models/enums/model_enums.dart';
import 'package:widget_models/models/child_model.dart';
import 'package:widget_models/property_models/key_model.dart';
import 'package:widget_models/widget_models/widgets/center_model.dart';

void main() {
  test("center model with no value test", () {
    final model = CenterModel(id: "4947U#");

    expect(ModelType.center, model.type);
    expect(Center, model.toWidget().runtimeType);
    expect("Center()", model.toCode());

    expect({
      "id": "4947U#",
      "type": "center",
      "properties": <String, dynamic>{},
      "children": <String, dynamic>{}
    }, model.toJson());
  });

  const Map<String, dynamic> sampleModelData = <String, dynamic>{
    "id": "47435",
    "type": "center",
    "properties": {
      "key": {"value": "unique", "type": "key"}
    },
    "children": {
      "child": {
        "type": "child",
        "children": [
          {
            "id": "35277C",
            "type": "center",
            "properties": <String, dynamic>{},
            "children": <String, dynamic>{}
          }
        ]
      }
    }
  };

  test("center model with value test", () {
    final model = CenterModel(
      id: "47435",
      properties: {
        "key": KeyProperty(
          value: KeyValueType.unique,
        )
      },
      children: {
        "child": ChildModel(
          children: [CenterModel(id: "35277C")],
        )
      },
    );

    expect(ModelType.center, model.type);
    expect(Center, model.toWidget().runtimeType);
    expect("Center(key:UniqueKey(),child:Center(),)", model.toCode());

    expect(sampleModelData, model.toJson());
  });

  test("center model from json", () {
    final model = CenterModel.fromJson(sampleModelData);

    expect(1, model.properties.length);
    expect(1, model.children["child"]?.children.length);
    expect(Center, model.toWidget().runtimeType);
  });
}
