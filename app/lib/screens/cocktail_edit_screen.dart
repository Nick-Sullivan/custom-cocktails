import 'package:custom_cocktails/widgets/cocktail/cocktail_controller.dart';
import 'package:custom_cocktails/widgets/cocktail_edit/cocktail_edit_view.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class CocktailEditScreen extends StatelessWidget {
  final controller = GetIt.instance<CocktailController>();
  CocktailEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: buildBody(context),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text("New cocktail"),
    );
  }

  Widget buildBody(BuildContext context) {
    return ListenableBuilder(
        listenable: controller,
        builder: (BuildContext context, Widget? child) {
          return SingleChildScrollView(
            child: CocktailEditView(
                controller: controller, key: const Key('cocktailView')),
          );
        });
  }
}
