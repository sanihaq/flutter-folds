import 'package:flutter/material.dart';
import 'package:flutter_fancy_tree_view/flutter_fancy_tree_view.dart';
import 'package:flutter_solidart/flutter_solidart.dart';
import 'package:modals/modals.dart';
import 'package:widget_models/models/widget_model.dart';

import '/utils/signals.dart';
import '../global/variables.dart';
import 'canvas_view.dart';
import 'code_view.dart';
import 'property_view.dart';
import 'tree_view.dart';

class AppLayout extends StatefulWidget {
  const AppLayout({super.key});

  @override
  State<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> with TickerProviderStateMixin {
  late final TabController _mobileTabController;
  late final TabController _desktopTabController;

  @override
  void initState() {
    super.initState();
    _mobileTabController =
        TabController(vsync: this, length: 4, animationDuration: Duration.zero);
    _mobileTabController.addListener(() {
      context.get<Signal<int>>(SignalId.currentViewTab).value =
          _mobileTabController.index;
    });
    _desktopTabController =
        TabController(vsync: this, length: 2, animationDuration: Duration.zero);
    _desktopTabController.addListener(() {
      context.get<Signal<int>>(SignalId.currentViewTab).value =
          _desktopTabController.index;
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
    _mobileTabController.dispose();
    _desktopTabController.dispose();
    super.dispose();
  }

  final propertyView = const PropertyView(key: ValueKey("propertyView"));
  final canvasView = const CanvasView(key: ValueKey("canvasView"));
  final codeView = const CodeView(key: ValueKey("codeView"));

  @override
  Widget build(final BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width <= 1200;
    removeAllModals();
    final treeView = ModelTreeView(
        key: const ValueKey("treView"), tagId: isMobile ? "mobile" : "desktop");
    return Scaffold(
      body: isMobile
          ? Stack(
              children: [
                TabBarView(
                  controller: _mobileTabController,
                  children: [
                    treeView,
                    Padding(
                      padding: const EdgeInsets.only(top: 40.0),
                      child: propertyView,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40.0),
                      child: canvasView,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40.0),
                      child: codeView,
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
                        labelColor:
                            Theme.of(context).textTheme.bodyLarge?.color,
                        unselectedLabelColor: Colors.grey,
                        splashBorderRadius: BorderRadius.circular(40),
                        controller: _mobileTabController,
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
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 400, child: treeView),
                const VerticalDivider(),
                Expanded(
                  child: Stack(
                    children: [
                      TabBarView(
                        controller: _desktopTabController,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 40.0),
                            child: canvasView,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 40.0),
                            child: codeView,
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
                              labelColor:
                                  Theme.of(context).textTheme.bodyLarge?.color,
                              unselectedLabelColor: Colors.grey,
                              splashBorderRadius: BorderRadius.circular(40),
                              controller: _desktopTabController,
                              tabs: const [
                                Tab(
                                    icon: Icon(Icons.slideshow_outlined,
                                        size: 22)),
                                Tab(icon: Icon(Icons.code_outlined, size: 22)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const VerticalDivider(),
                SizedBox(
                  width: 400,
                  child: propertyView,
                ),
              ],
            ),
    );
  }
}
