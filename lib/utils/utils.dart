import 'package:widget_models/models/widget_model.dart';
import 'package:widget_models/widget_models/root_model.dart';

import '../states/signals.dart';
import 'extensions.dart';

String getTitleFromEnum(final String type) {
  return type.split(".").last.capitalize();
}

void notifyRoot(final RootModel root) {
  if (currentRootSignal.value?.id == root.id) {
    // ignore: invalid_use_of_protected_member
    currentRootSignal.notifyListeners();
  }
}
