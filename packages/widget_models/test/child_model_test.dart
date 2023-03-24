import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:widget_models/enums/child_enums.dart';
import 'package:widget_models/models/child_model.dart';

import 'package:widget_models/widget_models/widgets/center.dart';

void main() {
  test('ChildModel can accept child', () {
    const model = ChildModel(children: []);
    expect(true, model.canAcceptChild);
  });
  test('ChildModel can not accept child', () {
    final model = ChildModel(children: [CenterModel(id: "id")]);
    expect(false, model.canAcceptChild);
  });
  test('ChildModel can accept children', () {
    final model =
        ChildModel(children: [CenterModel(id: "id")], type: ChildType.children);
    expect(true, model.canAcceptChild);
  });
}
