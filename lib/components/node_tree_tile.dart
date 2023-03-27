import 'package:flutter/material.dart';
import 'package:flutter_fancy_tree_view/flutter_fancy_tree_view.dart';
import 'package:widget_models/models/child_model.dart';

import '../global/variables.dart';
import '../models/tree_node.dart';

class NodeTreeTile extends StatefulWidget {
  const NodeTreeTile({
    required this.entry,
    required this.onTap,
    super.key,
  });

  final TreeEntry<TreeNode> entry;
  final VoidCallback onTap;

  @override
  State<NodeTreeTile> createState() => _NodeTreeTileState();
}

class _NodeTreeTileState extends State<NodeTreeTile> {
  final editFocusNode = FocusNode();
  final editingController = TextEditingController();
  bool _isOnHover = false;
  bool _isEdit = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(final BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      onHover: (final value) {
        setState(() {
          _isOnHover = value;
        });
      },
      child: TreeIndentation(
        entry: widget.entry,
        guide: const IndentGuide.scopingLines(origin: 1, indent: 20),
        child: Stack(
          children: [
            if (!_isEdit)
              Row(
                children: [
                  FolderButton(
                    icon: const Icon(Icons.remove),
                    openedIcon: const Icon(Icons.expand_more),
                    closedIcon: const Icon(Icons.chevron_right),
                    isOpen: widget.entry.hasChildren
                        ? widget.entry.isExpanded
                        : null,
                    onPressed: widget.entry.hasChildren ? widget.onTap : null,
                  ),
                  Text(widget.entry.node.title),
                ],
              )
            else
              TextField(
                controller: editingController,
                autofocus: true,
                focusNode: editFocusNode,
                decoration: InputDecoration(
                  hintText: widget.entry.node.title,
                  contentPadding: const EdgeInsets.only(left: 20, bottom: 10),
                  constraints: const BoxConstraints(maxHeight: 40),
                  border: InputBorder.none,
                ),
                onTapOutside: (final _) {
                  editFocusNode.unfocus();
                  setState(() {
                    _isEdit = false;
                  });
                  if (editingController.text != "") {
                    nodes[nodes.indexOf(widget.entry.node)] = widget.entry.node
                        .copyWith(title: editingController.text);
                    treeController.rebuild();
                  }
                },
                onSubmitted: (final value) {
                  nodes[nodes.indexOf(widget.entry.node)] =
                      widget.entry.node.copyWith(title: value);
                  setState(() {
                    _isEdit = false;
                  });
                  treeController.rebuild();
                },
              ),
            if (_isOnHover && !_isEdit)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (widget.entry.parent == null)
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.remove_red_eye, size: 16),
                    ),
                  if (widget.entry.parent == null)
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _isEdit = true;
                        });
                        editingController.text = widget.entry.node.title;
                        treeController.rebuild();
                      },
                      icon: const Icon(Icons.edit, size: 16),
                    ),
                  IconButton(
                    onPressed: () {
                      widget.entry.node.children.add(
                        TreeNode(
                          id: "${widget.entry.node.children.length + 1}",
                          title:
                              "child ${widget.entry.node.children.length + 1}",
                          children: [],
                        ),
                      );
                      treeController.rebuild();
                    },
                    icon: const Icon(Icons.add, size: 20),
                  ),
                  IconButton(
                    onPressed: () {
                      if (widget.entry.parent != null) {
                        widget.entry.parent?.node.children
                            .remove(widget.entry.node);
                      } else {
                        nodes.remove(widget.entry.node);
                      }
                      treeController.rebuild();
                    },
                    icon: const Icon(Icons.delete, size: 20),
                  )
                ],
              ),
          ],
        ),
      ),
    );
  }
}
