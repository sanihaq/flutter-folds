import 'package:flutter/material.dart';
import 'package:flutter_solidart/flutter_solidart.dart';
import 'package:widget_models/models/widget_model.dart';

import '/states/signals.dart';
import '/utils/db.dart';
import '/utils/signals.dart';
import 'global/variables.dart';
import 'models/fold_file.dart';
import 'views/app_layout.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  Future<FoldFile> _load() async {
    await Db.instance.getFolds();
    if (Db.instance.folds.isEmpty) {
      await Db.instance.createExampleFold();
    }
    final fold = Db.instance.folds.first;
    final foldsData = await Db.instance.getFold(fold.dataId);
    for (final data in foldsData) {
      models.add(WidgetModel.fromJson(data));
    }
    return fold;
  }

  @override
  Widget build(final BuildContext context) {
    return FutureBuilder(
      future: _load(),
      builder: (final context, final snapshot) {
        if (snapshot.data == null) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }
        final fold = snapshot.data!;
        return Solid(
          signals: {
            SignalId.themeMode: () => createSignal<ThemeMode>(ThemeMode.system),
            SignalId.currentViewTab: () => createSignal<int>(0),
            SignalId.currentFold: () => createSignal<FoldFile>(fold),
            SignalId.showOnlySetProperty: () => showOnlySetProperty,
            SignalId.currentRoot: () => currentRootSignal,
            SignalId.currentModel: () => createSignal<WidgetModel?>(null)
              ..addListener(() {
                // ignore: invalid_use_of_protected_member
                currentRootSignal.notifyListeners();
              }),
            SignalId.recentColors: () => recentColors,
          },
          child: Builder(
            builder: (final context) {
              final themeMode = context.observe<ThemeMode>(SignalId.themeMode);
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Flutter Folds',
                themeMode: themeMode,
                theme: ThemeData.light(useMaterial3: true),
                darkTheme: ThemeData.dark(useMaterial3: true),
                home: const AppLayout(),
              );
            },
          ),
        );
      },
    );
  }
}
