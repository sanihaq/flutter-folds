import '../enums/model_enums.dart';
import '../models/widget_model.dart';
import '../widget_models/material/material_app_model.dart';
import '../widget_models/material/scaffold_model.dart';
import '../widget_models/root_model.dart';
import '../widget_models/widgets/center_model.dart';
import '../widget_models/widgets/column_model.dart';
import '../widget_models/widgets/container_model.dart';
import '../widget_models/widgets/row_model.dart';

extension ModelExtension on ModelType {
  WidgetModel get model {
    switch (this) {
      case ModelType.center:
        return CenterModel();
      case ModelType.column:
        return ColumnModel();
      case ModelType.container:
        return ContainerModel();
      case ModelType.floatingActionButton:
        // TODO: Handle this case.
        break;
      case ModelType.icon:
        // TODO: Handle this case.
        break;
      case ModelType.materialApp:
        return MaterialAppModel();
      case ModelType.scaffold:
        return ScaffoldModel();
      case ModelType.text:
        // TODO: Handle this case.
        break;
      case ModelType.row:
        return RowModel();
      case ModelType.root:
        return RootModel(name: "Root");
    }
    return CenterModel();
  }

  WidgetModel fromJson(final Map<String, dynamic> json) {
    switch (this) {
      case ModelType.center:
        return CenterModel.fromJson(json);
      case ModelType.column:
        return ColumnModel.fromJson(json);
      case ModelType.container:
        return ContainerModel.fromJson(json);
        // TODO: Handle this case.
        break;
      case ModelType.floatingActionButton:
        // TODO: Handle this case.
        break;
      case ModelType.icon:
        // TODO: Handle this case.
        break;
      case ModelType.materialApp:
        return MaterialAppModel.fromJson(json);
      case ModelType.row:
        return RowModel.fromJson(json);
      case ModelType.scaffold:
        return ScaffoldModel.fromJson(json);
      case ModelType.text:
        // TODO: Handle this case.
        break;
      case ModelType.root:
        return RootModel.fromJson(json);
    }
    return CenterModel();
  }
}
