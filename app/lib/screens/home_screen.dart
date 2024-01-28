import 'package:custom_cocktails/screens/ingredients_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final int initialTab;
  const HomeScreen({super.key, required this.initialTab});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: initialTab,
        length: 2,
        child: Scaffold(
          appBar: AppBar(
              toolbarHeight: 0,
              bottom: const TabBar(tabs: [
                Tab(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Icon(Icons.insights), Text(" Ingredients")]),
                ),
                Tab(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Icon(Icons.receipt), Text(" Cocktails")]),
                ),
              ])),
          body: TabBarView(children: [
            IngredientsScreen(),
            IngredientsScreen(),
          ]),
        ));
  }
}
