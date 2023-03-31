import 'package:flutter/material.dart';
import 'package:flutter_solidart/flutter_solidart.dart';

import '../models/fold_file.dart';

enum SignalId {
  themeMode,
  currentViewTab,
  currentFold,
  currentRoot,
  currentModel,
  showOnlySetProperty,
}

FoldFile getCurrentFold(final BuildContext context) {
  return context.get<Signal<FoldFile>>(SignalId.currentFold).value;
}
