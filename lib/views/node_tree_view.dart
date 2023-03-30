import 'package:flutter/material.dart';
import 'package:flutter_fancy_tree_view/flutter_fancy_tree_view.dart';
import 'package:flutter_solidart/flutter_solidart.dart';
import 'package:modals/modals.dart';
import 'package:searchable_listview/searchable_listview.dart';
import 'package:widget_models/models/widget_model.dart';
import 'package:widget_models/widget_models/root_model.dart';

import '../components/node_tree_tile.dart';
import '../global/variables.dart';
import '../models/fold_file.dart';
import '../utils/db.dart';
import '../utils/signals.dart';

class NodeTreeView extends StatefulWidget {
  const NodeTreeView({super.key});

  @override
  _TreeViewState createState() => _TreeViewState();
}

class _TreeViewState extends State<NodeTreeView> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(vsync: this, length: 3, animationDuration: Duration.zero);
    treeController = TreeController<WidgetModel>(
      roots: models,
      childrenProvider: (final WidgetModel model) => model.getAllChildren(),
    );
    treeController.expandAll();
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
            SizedBox(
              width: 160,
              height: 40,
              child: TabBar(
                indicatorColor: Colors.transparent,
                automaticIndicatorColorAdjustment: false,
                dividerColor: Colors.transparent,
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: Theme.of(context).textTheme.bodyLarge?.color,
                unselectedLabelColor: Colors.grey,
                splashBorderRadius: BorderRadius.circular(40),
                controller: _tabController,
                tabs: const [
                  Tab(icon: Icon(Icons.segment, size: 22)),
                  Tab(icon: Icon(Icons.rule, size: 22)),
                  Tab(icon: Icon(Icons.slideshow_outlined, size: 22)),
                ],
              ),
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
          child: TabBarView(
            controller: _tabController,
            children: [
              TreeView<WidgetModel>(
                treeController: treeController,
                nodeBuilder: (final BuildContext context,
                    final TreeEntry<WidgetModel> entry) {
                  return NodeTreeTile(
                    key: ValueKey(entry.node),
                    entry: entry,
                    onTap: () {
                      // print(entry.node.toJson());
                    },
                  );
                },
              ),
              const Icon(Icons.rule, size: 100),
              const Icon(Icons.slideshow_outlined, size: 100),
            ],
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

const _renameCode = "*rename+hdfs89ryif";

class _FoldListState extends State<FoldList> {
  List<FoldFile> folds = [];

  @override
  void initState() {
    super.initState();
    setFolds();
  }

  void setFolds() {
    setState(() {
      folds = Db.instance.folds;
    });
  }

  @override
  Widget build(final BuildContext context) {
    return Material(
      elevation: 8.0,
      child: SearchableList<FoldFile>(
        initialList: folds,
        searchFieldEnabled: true,
        spaceBetweenSearchAndList: 0,
        inputDecoration: InputDecoration(
          hintText: "Folds",
          contentPadding: const EdgeInsets.only(left: 20, top: 10),
          border: InputBorder.none,
          suffix: const SizedBox.shrink(),
          suffixIcon: IconButton(
            onPressed: () async {
              await Db.instance.createNewFold(_renameCode);
              setFolds();
            },
            icon: const Icon(Icons.create_new_folder_outlined),
          ),
        ),
        filter: (final search) {
          return Db.instance.folds
              .where((final e) => e.name.contains(search))
              .toList();
        },
        builder: (final fold) {
          return InkWell(
            onTap: () {
              removeModal('showFoldsListModal');
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: FoldListItem(
                  key: ValueKey(fold.id), fold: fold, setFolds: setFolds),
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
    required this.setFolds,
    super.key,
  });

  final FoldFile fold;
  final void Function() setFolds;

  @override
  State<FoldListItem> createState() => _FoldListItemState();
}

class _FoldListItemState extends State<FoldListItem> {
  final editFocusNode = FocusNode();
  final editingController = TextEditingController();
  bool _isEdit = false;
  late FoldFile _fold;

  final _newFoldName = "New Fold";

  @override
  void initState() {
    super.initState();
    _fold = widget.fold;
    if (_fold.name == _renameCode) {
      setState(() {
        _isEdit = true;
      });
      editFocusNode.requestFocus();
    }
  }

  void _rename() {
    late final FoldFile newFold;
    if (_fold.name == _renameCode) {
      newFold = _fold.copyWith(name: _newFoldName);
      Db.instance.renameFold(newFold);
    } else if (editingController.text != "") {
      newFold = _fold.copyWith(name: editingController.text);
      Db.instance.renameFold(newFold);
    }
    setState(() {
      _fold = newFold;
      _isEdit = false;
    });
  }

  @override
  Widget build(final BuildContext context) {
    return Stack(
      children: [
        if (_isEdit)
          SizedBox(
            width: 250 - 8,
            child: TextField(
              focusNode: editFocusNode,
              controller: editingController,
              autofocus: true,
              onTapOutside: (final _) {
                if (_fold.name == _renameCode) {
                  final newFold = _fold.copyWith(name: _newFoldName);
                  Db.instance.renameFold(newFold);
                  setState(() {
                    _fold = newFold;
                  });
                }
                setState(() {
                  _isEdit = false;
                });
                editFocusNode.unfocus();
              },
              onSubmitted: (final value) {
                _rename();
              },
              decoration: InputDecoration(
                hintText: _fold.name == _renameCode ? _newFoldName : _fold.name,
                contentPadding: const EdgeInsets.all(0),
                border: InputBorder.none,
                suffix: IconButton(
                  onPressed: () {
                    _rename();
                  },
                  icon: const Icon(Icons.save_outlined, size: 16),
                ),
              ),
            ),
          )
        else
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Text(_fold.name),
          ),
        if (!_isEdit)
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
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
                  widget.setFolds();
                  await Future<void>.delayed(const Duration(milliseconds: 300));
                  if (Db.instance.folds.isEmpty) {
                    await Db.instance.createExampleFold();
                    widget.setFolds();
                  }
                },
                icon: const Icon(Icons.delete, size: 16),
              )
            ],
          )
      ],
    );
  }
}
