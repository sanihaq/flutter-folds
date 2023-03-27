import 'package:flutter/material.dart';
import 'package:flutter_fancy_tree_view/flutter_fancy_tree_view.dart';
import 'package:widget_models/models/widget_model.dart';
import 'package:widget_models/widget_models/root_model.dart';

import '../components/node_tree_tile.dart';
import '../global/variables.dart';

class NodeTreeView extends StatefulWidget {
  const NodeTreeView({super.key});

  @override
  _TreeViewState createState() => _TreeViewState();
}

class _TreeViewState extends State<NodeTreeView> {
  @override
  void initState() {
    super.initState();
    treeController = TreeController<WidgetModel>(
      roots: models,
      childrenProvider: (final WidgetModel model) => model.getAllChildren(),
    );
  }

  @override
  void dispose() {
    treeController.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    return Stack(
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () {
                models.add(RootModel(name: "Root ${models.length + 1}"));
                treeController.rebuild();
              },
              icon: const Icon(Icons.add),
            )
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
                  print(entry.node.toJson());
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
