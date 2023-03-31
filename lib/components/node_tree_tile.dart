import 'package:flutter/material.dart';
import 'package:flutter_fancy_tree_view/flutter_fancy_tree_view.dart';
import 'package:flutter_solidart/flutter_solidart.dart';
import 'package:modals/modals.dart';
import 'package:searchable_listview/searchable_listview.dart';
import 'package:widget_models/enums/model_enums.dart';
import 'package:widget_models/extensions/model_extension.dart';
import 'package:widget_models/models/widget_model.dart';
import 'package:widget_models/widget_models/root_model.dart';

import '../global/variables.dart';
import '../states/signals.dart';
import '../utils/signals.dart';
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
  final addBtnKey = GlobalKey();
  final editFocusNode = FocusNode();
  final editingController = TextEditingController();
  bool _isOnHover = false;
  bool _isEdit = false;
  bool _isModalShowing = false;
  late final String title;

  @override
  void initState() {
    if (widget.entry.node is RootModel) {
      title = (widget.entry.node as RootModel).name;
    } else {
      title = getTitleFromEnum(widget.entry.node.type.toString());
    }
    super.initState();
  }

  void _rename() {
    final index = models.indexOf(widget.entry.node);
    if (index >= 0) {
      final newNode = (widget.entry.node as RootModel)
          .copyWith(name: editingController.text) as RootModel;
      models[index] = newNode;
      treeController.rebuild();
      if (widget.entry.isExpanded) {
        treeController.expand(newNode);
      }
      currentRootSignal.value = newNode;
    }
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
                  suffix: IconButton(
                    onPressed: () {
                      setState(() {
                        _isEdit = false;
                      });
                      _rename();
                    },
                    icon: const Icon(Icons.save_outlined, size: 16),
                  ),
                ),
                onTapOutside: (final _) {
                  setState(() {
                    _isEdit = false;
                  });
                  if (editingController.text != "" &&
                      editingController.text != title) {
                    _rename();
                  }
                  editFocusNode.unfocus();
                },
                onSubmitted: (final value) {
                  setState(() {
                    _isEdit = false;
                  });
                  _rename();
                },
              ),
            if (_isModalShowing || _isOnHover && !_isEdit)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (widget.entry.parent == null)
                    IconButton(
                      onPressed: _isModalShowing ? null : () {},
                      icon: const Icon(Icons.remove_red_eye, size: 16),
                    ),
                  if (widget.entry.parent == null)
                    IconButton(
                      onPressed: _isModalShowing
                          ? null
                          : () {
                              editingController.text = title;
                              setState(() {
                                _isEdit = true;
                              });
                            },
                      icon: const Icon(Icons.edit, size: 16),
                    ),
                  ModalAnchor(
                    tag: 'anchor+${widget.entry.node.id}',
                    child: IconButton(
                      key: addBtnKey,
                      onPressed: !_isModalShowing &&
                              widget.entry.node.children.values
                                  .any((final e) => e.canAcceptChild)
                          ? () {
                              final RenderBox? renderbox =
                                  addBtnKey.currentContext!.findRenderObject()
                                      as RenderBox?;
                              final Offset position =
                                  renderbox!.localToGlobal(Offset.zero);
                              final double y = position.dy;
                              const maxHeight = 500.0;
                              const minHeight = 300.0;
                              final minConstraints = y >
                                  MediaQuery.of(context).size.height -
                                      minHeight;
                              final height =
                                  MediaQuery.of(context).size.height - (y + 60);
                              setState(() {
                                _isModalShowing = true;
                              });
                              late final String group;
                              if (widget.entry.node.children.length == 1) {
                                group = widget.entry.node.children.keys.first;
                              } else {
                                group = "x";
                              }
                              showModal(
                                ModalEntry.anchored(
                                  context,
                                  tag: 'showModelTypesModal',
                                  anchorTag: 'anchor+${widget.entry.node.id}',
                                  modalAlignment: minConstraints
                                      ? Alignment.bottomRight
                                      : Alignment.topRight,
                                  anchorAlignment: Alignment.bottomLeft,
                                  barrierDismissible: true,
                                  child: SizedBox(
                                    height: minConstraints || height > maxHeight
                                        ? maxHeight
                                        : height,
                                    width: 250,
                                    child: Material(
                                      elevation: 8.0,
                                      child: SearchableList<ModelType>(
                                        initialList: ModelType.values,
                                        autoFocusOnSearch: true,
                                        spaceBetweenSearchAndList: 0,
                                        filter: (final search) {
                                          final sorted = modelTypeValues.keys
                                              .where((final e) => e.contains(
                                                  search.toLowerCase()));
                                          return sorted
                                              .map((final e) =>
                                                  modelTypeValues[e]!)
                                              .toList();
                                        },
                                        builder: (final type) {
                                          return InkWell(
                                            onTap: () {
                                              removeModal(
                                                  'showModelTypesModal');
                                              final children = widget
                                                  .entry.node.children[group];
                                              if (children != null) {
                                                widget.entry.node
                                                        .children[group] =
                                                    children.copyWith(
                                                        children: [
                                                      ...children.children,
                                                      type.model
                                                    ]);
                                              }
                                              treeController.rebuild();
                                              if (!widget.entry.isExpanded) {
                                                treeController.toggleExpansion(
                                                    widget.entry.node);
                                              }
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(getTitleFromEnum(
                                                  type.toString())),
                                            ),
                                          );
                                        },
                                        displayClearIcon: false,
                                        inputDecoration: const InputDecoration(
                                          hintText: "search",
                                          contentPadding:
                                              EdgeInsets.only(left: 20),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ),
                                  onRemove: () {
                                    setState(() {
                                      _isModalShowing = false;
                                    });
                                  },
                                ),
                              );
                            }
                          : null,
                      icon: const Icon(Icons.add, size: 20),
                    ),
                  ),
                  IconButton(
                    onPressed: _isModalShowing
                        ? null
                        : () {
                            if (widget.entry.parent != null) {
                              for (final key
                                  in widget.entry.parent!.node.children.keys) {
                                if (widget
                                    .entry.parent!.node.children[key]!.children
                                    .contains(widget.entry.node)) {
                                  widget.entry.parent!.node.children[key]!
                                      .children
                                      .remove(widget.entry.node);
                                  break;
                                }
                              }
                            } else {
                              models.remove(widget.entry.node);
                            }
                            if (widget.entry.node.id ==
                                context
                                    .get<Signal<WidgetModel?>>(
                                        SignalId.currentModel)
                                    .value
                                    ?.id) {
                              context
                                  .get<Signal<WidgetModel?>>(
                                      SignalId.currentModel)
                                  .value = null;
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
