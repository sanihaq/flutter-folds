import '../enums/model_enums.dart';
import '../models/widget_model.dart';
import '../widget_models/widgets/center_model.dart';

extension ModelExtension on ModelType {
  WidgetModel get model {
    switch (this) {
      case ModelType.center:
        return CenterModel();
      case ModelType.column:
        // TODO: Handle this case.
        break;
      case ModelType.container:
        // TODO: Handle this case.
        break;
      case ModelType.floatingActionButton:
        // TODO: Handle this case.
        break;
      case ModelType.icon:
        // TODO: Handle this case.
        break;
      case ModelType.materialApp:
        // TODO: Handle this case.
        break;
      case ModelType.scaffold:
        // TODO: Handle this case.
        break;
      case ModelType.text:
        // TODO: Handle this case.
        break;
    }
    return CenterModel();
  }

  WidgetModel fromJson(final Map<String, dynamic> json) {
    switch (this) {
      case ModelType.center:
        return CenterModel.fromJson(json);
      case ModelType.column:
        // TODO: Handle this case.
        break;
      case ModelType.container:
        // TODO: Handle this case.
        break;
      case ModelType.floatingActionButton:
        // TODO: Handle this case.
        break;
      case ModelType.icon:
        // TODO: Handle this case.
        break;
      case ModelType.materialApp:
        // TODO: Handle this case.
        break;
      case ModelType.scaffold:
        // TODO: Handle this case.
        break;
      case ModelType.text:
        // TODO: Handle this case.
        break;
    }
    return CenterModel();
  }
}
