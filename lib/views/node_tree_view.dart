import 'package:flutter/material.dart';
import 'package:flutter_fancy_tree_view/flutter_fancy_tree_view.dart';
import 'package:modals/modals.dart';
import 'package:searchable_listview/searchable_listview.dart';
import 'package:widget_models/models/widget_model.dart';
import 'package:widget_models/widget_models/root_model.dart';

import '../components/node_tree_tile.dart';
import '../global/variables.dart';
import '../models/folds_file.dart';
import '../utils/db.dart';

class NodeTreeView extends StatefulWidget {
  const NodeTreeView({super.key});

  @override
  _TreeViewState createState() => _TreeViewState();
}

class _TreeViewState extends State<NodeTreeView> {
  @override
  void initState() {
    super.initState();
    Db.instance.getFiles();
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
                  onPressed: () {},
                  icon: const Icon(Icons.save_outlined),
                ),
                IconButton(
                  onPressed: () {
                    Db.instance
                        .createNewFold("fold ${Db.instance.files.length + 1}");
                  },
                  icon: const Icon(Icons.create_new_folder_outlined),
                ),
                ModalAnchor(
                  tag: "folds-btn",
                  child: IconButton(
                    onPressed: () {
                      showModal(ModalEntry.anchored(
                        context,
                        tag: 'showFoldsListModal',
                        anchorTag: "folds-btn",
                        modalAlignment: Alignment.topRight,
                        anchorAlignment: Alignment.center,
                        barrierDismissible: true,
                        child: const SizedBox(
                          width: 250,
                          height: 400,
                          child: FoldList(),
                        ),
                      ));
                    },
                    icon: const Icon(Icons.featured_play_list_outlined),
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

class FoldList extends StatefulWidget {
  const FoldList({
    super.key,
  });

  @override
  State<FoldList> createState() => _FoldListState();
}

class _FoldListState extends State<FoldList> {
  @override
  Widget build(final BuildContext context) {
    return Material(
      elevation: 8.0,
      child: SearchableList<FoldsFile>(
        initialList: Db.instance.files,
        searchFieldEnabled: false,
        // inputDecoration: const InputDecoration(
        //   hintText: "search",
        //   contentPadding: EdgeInsets.only(left: 20),
        //   border: InputBorder.none,
        // ),
        filter: (final search) {
          return Db.instance.files;
        },
        builder: (final fold) {
          return InkWell(
            onTap: () {
              removeModal('showFoldsListModal');
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: FoldListItem(fold: fold),
            ),
          );
        },
      ),
    );
  }
}

class FoldListItem extends StatefulWidget {
  const FoldListItem({
    required this.fold,
    super.key,
  });

  final FoldsFile fold;

  @override
  State<FoldListItem> createState() => _FoldListItemState();
}

class _FoldListItemState extends State<FoldListItem> {
  final editFocusNode = FocusNode();
  final editingController = TextEditingController();
  bool _isEdit = false;
  late FoldsFile _fold;

  @override
  void initState() {
    super.initState();
    _fold = widget.fold;
  }

  @override
  Widget build(final BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (!_isEdit)
          Text(_fold.name)
        else
          SizedBox(
            width: 250 - 8,
            child: TextField(
              focusNode: editFocusNode,
              controller: editingController,
              autofocus: true,
              onTapOutside: (final _) {
                setState(() {
                  editFocusNode.unfocus();
                  _isEdit = false;
                });
              },
              onSubmitted: (final value) {
                final newFold = _fold.copyWith(name: value);
                Db.instance.renameFold(newFold);
                setState(() {
                  _fold = newFold;
                });
                setState(() {
                  editFocusNode.unfocus();
                  _isEdit = false;
                });
              },
              decoration: InputDecoration(
                hintText: _fold.name,
                contentPadding: const EdgeInsets.all(0),
                border: InputBorder.none,
                suffix: IconButton(
                  onPressed: () {
                    setState(() {
                      final newFold =
                          _fold.copyWith(name: editingController.text);
                      Db.instance.renameFold(newFold);
                      setState(() {
                        _fold = newFold;
                      });
                      editFocusNode.unfocus();
                      _isEdit = false;
                    });
                  },
                  icon: const Icon(Icons.save_outlined, size: 16),
                ),
              ),
            ),
          ),
        if (!_isEdit)
          Row(
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    editingController.text = _fold.name;
                    _isEdit = true;
                  });
                },
                icon: const Icon(Icons.edit, size: 16),
              ),
              IconButton(
                onPressed: () async {
                  await Db.instance.deleteFold(_fold);
                  removeModal('showFoldsListModal');
                },
                icon: const Icon(Icons.delete, size: 16),
              )
            ],
          )
      ],
    );
  }
}
