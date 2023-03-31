import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_solidart/flutter_solidart.dart';

import '../states/signals.dart';

class CanvasView extends StatelessWidget {
  const CanvasView({super.key});

  @override
  Widget build(final BuildContext context) {
    return SignalBuilder(
      signal: currentRootSignal,
      builder: (final context, final model, final _) {
        return model != null
            ? model.toWidget()
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          model != null ? model.name : "select a root",
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
