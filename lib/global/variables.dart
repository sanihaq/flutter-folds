import 'package:flutter_fancy_tree_view/flutter_fancy_tree_view.dart';
import 'package:widget_models/enums/model_enums.dart';
import 'package:widget_models/models/widget_model.dart';

final List<WidgetModel> models = <WidgetModel>[];

late final TreeController<WidgetModel> treeController;

final modelTypeValues = <String, ModelType>{
  for (var type in [...ModelType.values]..remove(ModelType.root))
    type.toString().split('.').last.toLowerCase(): type
};
