import 'package:flutter/material.dart';
import 'package:flutter_solidart/flutter_solidart.dart';
import 'package:widget_models/models/property_model.dart';
import 'package:widget_models/models/widget_model.dart';

import '../components/property_input.dart';
import '../states/signals.dart';
import '../utils/signals.dart';
import '../utils/utils.dart';

class PropertyView extends StatelessWidget {
  const PropertyView({super.key});

  @override
  Widget build(final BuildContext context) {
    return SignalBuilder(
      signal: context.get<Signal<WidgetModel?>>(SignalId.currentModel),
      builder: (final context, final model, final _) {
        return Stack(
          children: [
            if (model != null)
              Padding(
                padding: const EdgeInsets.only(top: 32.0),
                child: SingleChildScrollView(
                  child: PropertyEditingWidget(properties: model.properties),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                mainAxisAlignment: model != null
                    ? MainAxisAlignment.spaceBetween
                    : MainAxisAlignment.center,
                children: [
                  Text(
                    model != null
                        ? getTitleFromEnum(model.type.toString())
                        : "select a node to edit it's properties.",
                  ),
                  if (model != null)
                    SignalBuilder(
                      signal: showOnlySetProperty,
                      builder: (final context, final value, final child) {
                        return IconButton(
                          onPressed: () {
                            showOnlySetProperty.value = !value;
                          },
                          icon: Icon(
                            showOnlySetProperty.value
                                ? Icons.toggle_on_outlined
                                : Icons.toggle_off_outlined,
                          ),
                        );
                      },
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

class PropertyEditingWidget extends StatelessWidget {
  const PropertyEditingWidget({
    required this.properties,
    this.isTopMost = true,
    this.leftPadding = 4,
    super.key,
  });

  // ignore: strict_raw_type
  final Map<String, PropertyModel> properties;
  final bool isTopMost;
  final double leftPadding;

  @override
  Widget build(final BuildContext context) {
    return SignalBuilder(
      signal: context.get<Signal<bool>>(SignalId.showOnlySetProperty),
      builder: (final context, final showOnlySet, final child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children:
              (properties.keys.toList()..sort()).map((final propertyName) {
            final property = properties[propertyName]!;
            if (showOnlySet && property.value == property.defaultValue) {
              return const SizedBox();
            }
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: leftPadding,
                          top: 4.0,
                          bottom: 4.0,
                          right: 4.0,
                        ),
                        child: SizedBox(
                          width: 180,
                          child: Text(propertyName),
                        ),
                      ),
                      getPropertyInput<dynamic>(
                        property,
                        (final property) {
                          properties[propertyName] = property;
                          context
                              .get<Signal<WidgetModel?>>(SignalId.currentModel)
                              // ignore: invalid_use_of_protected_member
                              .notifyListeners();
                        },
                      ),
                    ],
                  ),
                ),
                PropertyEditingWidget(
                  properties: property.resolverProperties,
                  isTopMost: false,
                  leftPadding: leftPadding + leftPadding,
                ),
                if (isTopMost) const Divider(),
              ],
            );
          }).toList(),
        );
      },
    );
  }
}
