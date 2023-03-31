import 'package:flutter/material.dart';
import 'package:flutter_fancy_tree_view/flutter_fancy_tree_view.dart';
import 'package:flutter_solidart/flutter_solidart.dart';
import 'package:modals/modals.dart';
import 'package:widget_models/models/widget_model.dart';
import 'package:widget_models/widget_models/root_model.dart';

import '../components/fold_file.dart';
import '../global/variables.dart';
import '../models/fold_file.dart';
import '../utils/signals.dart';
import 'canvas_view.dart';
import 'code_view.dart';
import 'property_view.dart';
import 'tree_view.dart';

class MobileView extends StatefulWidget {
  const MobileView({super.key});

  @override
  _TreeViewState createState() => _TreeViewState();
}

class _TreeViewState extends State<MobileView> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(vsync: this, length: 4, animationDuration: Duration.zero);
    _tabController.addListener(() {
      context.get<Signal<int>>(SignalId.currentViewTab).value =
          _tabController.index;
    });
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
            SignalBuilder(
              signal: context.get<Signal<int>>(SignalId.currentViewTab),
              builder: (final context, final value, final _) {
                if (value == 0) {
                  return IconButton(
                    onPressed: () {
                      models.add(RootModel(name: "Root ${models.length + 1}"));
                      treeController.rebuild();
                    },
                    icon: const Icon(Icons.add),
                  );
                } else if (value == 1) {
                  return IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      true
                          ? Icons.toggle_on_outlined
                          : Icons.toggle_off_outlined,
                    ),
                  );
                } else if (value == 2) {
                  return IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.ads_click, size: 20),
                  );
                } else {
                  return IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.content_copy_outlined, size: 18),
                  );
                }
              },
            ),
            SizedBox(
              width: 220,
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
                  Tab(icon: Icon(Icons.code_outlined, size: 22)),
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
              const ModelTreeView(),
              const PropertyView(),
              const CanvasView(),
              const CodeView(),
            ],
          ),
        ),
      ],
    );
  }
}
