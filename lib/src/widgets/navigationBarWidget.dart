
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:health_and_hope/src/utils/helpers.dart';

class NavigationBarWidgets extends StatefulWidget {
  PageController? pageController;
  final List<TabItem> itemsNavigation;
  final List<Widget> children;
  final int initialPage;

  NavigationBarWidgets({required this.itemsNavigation, this.initialPage = 0, required this.children}){
    pageController = PageController(initialPage: initialPage);
  }

  @override
  _NavigationBarWidgetsState createState() => _NavigationBarWidgetsState();
}

class _NavigationBarWidgetsState extends State<NavigationBarWidgets> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: widget.pageController,
        children: widget.children
      ),
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: HelpersAppsColors().colorBase,
        style: TabStyle.reactCircle,
        items: widget.itemsNavigation,
        initialActiveIndex: widget.initialPage,
        onTap: (int i) => widget.pageController!.jumpToPage(i),
      ),
    );
  }
}
