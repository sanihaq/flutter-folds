import 'package:flutter/material.dart';
import 'package:flutter_fancy_tree_view/flutter_fancy_tree_view.dart';
import 'package:widget_models/models/widget_model.dart';
import 'package:widget_models/widget_models/root_model.dart';
import 'package:widget_models/widget_models/widgets/center_model.dart';

import '../global/variables.dart';
import '../utils/utils.dart';

class NodeTreeTile extends StatefulWidget {
  const NodeTreeTile({
    required this.entry,
    required this.onTap,
    super.key,
  });

  final TreeEntry<WidgetModel> entry;
  final VoidCallback onTap;

  @override
  State<NodeTreeTile> createState() => _NodeTreeTileState();
}

class _NodeTreeTileState extends State<NodeTreeTile> {
  final editFocusNode = FocusNode();
  final editingController = TextEditingController();
  bool _isOnHover = false;
  bool _isEdit = false;
  late final String title;

  @override
  void initState() {
    if (widget.entry.node is RootModel) {
      title = (widget.entry.node as RootModel).name;
    } else {
      title = getTitleFromEnum(widget.entry.node.type);
    }
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
                    onPressed: widget.entry.hasChildren
                        ? () {
                            treeController.toggleExpansion(widget.entry.node);
                          }
                        : null,
                  ),
                  if (widget.entry.parent != null)
                    Builder(builder: (final _) {
                      for (final key
                          in widget.entry.parent!.node.children.keys) {
                        if (widget.entry.parent!.node.children[key]!.children
                            .any((final e) => e.id == widget.entry.node.id)) {
                          return Text(
                            "$key ",
                            style: Theme.of(context).textTheme.bodySmall,
                          );
                        }
                      }
                      return const Text("");
                    }),
                  Text(title),
                ],
              )
            else
              TextField(
                controller: editingController,
                autofocus: true,
                focusNode: editFocusNode,
                decoration: InputDecoration(
                  hintText: title,
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
                    models[models.indexOf(widget.entry.node)] =
                        (widget.entry.node as RootModel)
                            .copyWith(name: editingController.text);
                    treeController.rebuild();
                  }
                },
                onSubmitted: (final value) {
                  models[models.indexOf(widget.entry.node)] =
                      (widget.entry.node as RootModel).copyWith(name: value);
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
                        editingController.text = title;
                        treeController.rebuild();
                      },
                      icon: const Icon(Icons.edit, size: 16),
                    ),
                  IconButton(
                    onPressed: widget.entry.node.children.values
                            .any((final e) => e.canAcceptChild)
                        ? () {
                            final children =
                                widget.entry.node.children["child"];
                            if (children != null) {
                              widget.entry.node.children["child"] = children
                                  .copyWith(children: [
                                ...children.children,
                                CenterModel()
                              ]);
                            }
                            treeController.rebuild();
                            if (!widget.entry.isExpanded) {
                              treeController.toggleExpansion(widget.entry.node);
                            }
                          }
                        : null,
                    icon: const Icon(Icons.add, size: 20),
                  ),
                  IconButton(
                    onPressed: () {
                      if (widget.entry.parent != null) {
                        for (final key
                            in widget.entry.parent!.node.children.keys) {
                          if (widget.entry.parent!.node.children[key]!.children
                              .contains(widget.entry.node)) {
                            widget.entry.parent!.node.children[key]!.children
                                .remove(widget.entry.node);
                            break;
                          }
                        }
                      } else {
                        models.remove(widget.entry.node);
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
