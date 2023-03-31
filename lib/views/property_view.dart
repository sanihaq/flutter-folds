import 'package:flutter/material.dart';
import 'package:flutter_solidart/flutter_solidart.dart';
import 'package:widget_models/models/widget_model.dart';

import '../components/property_input.dart';
import '../utils/signals.dart';
import '../utils/utils.dart';

class PropertyView extends StatelessWidget {
  const PropertyView({super.key});

  @override
  Widget build(final BuildContext context) {
    return DualSignalBuilder(
      firstSignal: context.get<Signal<WidgetModel?>>(SignalId.currentModel),
      secondSignal: context.get<Signal<bool>>(SignalId.showOnlySetProperty),
      builder: (final context, final model, final showOnlySet, final _) {
        return Stack(
          children: [
            if (model != null)
              Padding(
                padding: const EdgeInsets.only(top: 32.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: (model.properties.keys.toList()..sort())
                        .map((final propertyName) {
                      final property = model.properties[propertyName]!;
                      if (showOnlySet &&
                          property.value == property.defaultValue) {
                        return const SizedBox();
                      }
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: SizedBox(
                                width: 180,
                                child: Text(propertyName),
                              ),
                            ),
                            getPropertyInput<dynamic>(
                              property,
                              (final property) {
                                model.properties[propertyName] = property;
                                context
                                    .get<Signal<WidgetModel?>>(
                                        SignalId.currentModel)
                                    // ignore: invalid_use_of_protected_member
                                    .notifyListeners();
                              },
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    model != null
                        ? getTitleFromEnum(model.type.toString())
                        : "Select a node to edit it's properties.",
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
