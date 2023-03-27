import 'package:flutter/material.dart';
import 'package:flutter_fancy_tree_view/flutter_fancy_tree_view.dart';

import '../components/node_tree_tile.dart';
import '../global/variables.dart';
import '../models/tree_node.dart';

class NodeTreeView extends StatefulWidget {
  const NodeTreeView({super.key});

  @override
  _TreeViewState createState() => _TreeViewState();
}

class _TreeViewState extends State<NodeTreeView> {
  @override
  void initState() {
    super.initState();
    treeController = TreeController<TreeNode>(
      roots: nodes,
      childrenProvider: (final TreeNode node) => node.children,
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
                nodes.add(
                  TreeNode(
                    id: "${nodes.length + 1}",
                    title: 'Root ${nodes.length + 1}',
                    children: <TreeNode>[],
                  ),
                );
                treeController.rebuild();
              },
              icon: const Icon(Icons.add),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 40.0),
          child: TreeView<TreeNode>(
            treeController: treeController,
            nodeBuilder:
                (final BuildContext context, final TreeEntry<TreeNode> entry) {
              return NodeTreeTile(
                key: ValueKey(entry.node),
                entry: entry,
                onTap: () => treeController.toggleExpansion(entry.node),
              );
            },
          ),
        ),
      ],
    );
  }
}
