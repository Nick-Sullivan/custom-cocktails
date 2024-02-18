import 'package:custom_cocktails/screens/cocktail_list_screen.dart';
import 'package:custom_cocktails/screens/invent_screen.dart';
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
                      children: [Icon(Icons.star_rounded), Text(" Invent")]),
                ),
                Tab(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Icon(Icons.liquor), Text(" Saved Cocktails")]),
                ),
              ])),
          body: TabBarView(children: [
            InventScreen(),
            CocktailListScreen(),
          ]),
        ));
  }
}
