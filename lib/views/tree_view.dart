import 'package:flutter/material.dart';
import 'package:flutter_fancy_tree_view/flutter_fancy_tree_view.dart';
import 'package:flutter_solidart/flutter_solidart.dart';
import 'package:modals/modals.dart';
import 'package:widget_models/models/widget_model.dart';
import 'package:widget_models/widget_models/root_model.dart';

import '../components/fold_file.dart';
import '../components/node_tree_tile.dart';
import '../global/variables.dart';
import '../models/fold_file.dart';
import '../states/signals.dart';
import '../utils/signals.dart';

class ModelTreeView extends StatelessWidget {
  const ModelTreeView({
    required this.tagId,
    super.key,
  });
  final String tagId;
  @override
  Widget build(final BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                models.add(RootModel(name: "Root ${models.length + 1}"));
                treeController.rebuild();
              },
              icon: const Icon(Icons.add),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    final fold = getCurrentFold(context);
                    final data = treeController.roots
                        .map((final e) => e.toJson())
                        .toList();
                    fold.saveData(data);
                  },
                  icon: const Icon(Icons.save_outlined),
                ),
                ModalAnchor(
                  tag: "folds-btn-$tagId",
                  child: IconButton(
                    onPressed: () {
                      showModal(ModalEntry.anchored(
                        context,
                        tag: 'showFoldsListModal',
                        anchorTag: "folds-btn-$tagId",
                        modalAlignment: Alignment.topRight,
                        anchorAlignment: Alignment.center,
                        barrierDismissible: true,
                        child: const SizedBox(
                          width: 280,
                          height: 400,
                          child: FoldList(),
                        ),
                      ));
                    },
                    icon: const Icon(Icons.topic_outlined),
                  ),
                ),
              ],
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 40.0),
          child: TreeView<WidgetModel>(
            treeController: treeController,
            nodeBuilder: (final BuildContext context,
                final TreeEntry<WidgetModel> entry) {
              return NodeTreeTile(
                key: ValueKey(entry.node),
                entry: entry,
                onTap: () {
                  context
                      .get<Signal<WidgetModel?>>(SignalId.currentModel)
                      .value = entry.node;
                  if (entry.node is RootModel) {
                    currentRootSignal.value = entry.node as RootModel;
                  }
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
