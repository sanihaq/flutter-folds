import 'package:flutter/material.dart';
import 'package:flutter_fancy_tree_view/flutter_fancy_tree_view.dart';
import 'package:flutter_solidart/flutter_solidart.dart';
import 'package:modals/modals.dart';
import 'package:searchable_listview/searchable_listview.dart';
import 'package:widget_models/models/widget_model.dart';
import 'package:widget_models/widget_models/root_model.dart';

import '../components/node_tree_tile.dart';
import '../global/variables.dart';
import '../states/signals.dart';
import '../utils/signals.dart';

class ModelTreeView extends StatelessWidget {
  const ModelTreeView({super.key});

  @override
  Widget build(final BuildContext context) {
    return TreeView<WidgetModel>(
      treeController: treeController,
      nodeBuilder:
          (final BuildContext context, final TreeEntry<WidgetModel> entry) {
        return NodeTreeTile(
          key: ValueKey(entry.node),
          entry: entry,
          onTap: () {
            context.get<Signal<WidgetModel?>>(SignalId.currentModel).value =
                entry.node;
            if (entry.node is RootModel) {
              currentRootSignal.value = entry.node as RootModel;
            }
          },
        );
      },
    );
  }
}
