import 'package:flutter/material.dart';
import 'package:flutter_fancy_tree_view/flutter_fancy_tree_view.dart';
import 'package:flutter_solidart/flutter_solidart.dart';
import 'package:modals/modals.dart';
import 'package:widget_models/models/widget_model.dart';
import 'package:widget_models/widget_models/root_model.dart';

import '../components/fold_file.dart';
import '../global/variables.dart';
import '../models/fold_file.dart';
import '../states/signals.dart';
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
        TabBarView(
          controller: _tabController,
          children: [
            const ModelTreeView(),
            const Padding(
              padding: EdgeInsets.only(top: 40.0),
              child: PropertyView(),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 40.0),
              child: CanvasView(),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 40.0),
              child: CodeView(),
            ),
          ],
        ),
        SizedBox(
          height: 40,
          child: Center(
            child: SizedBox(
              width: 220,
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
          ),
        ),
      ],
    );
  }
}
