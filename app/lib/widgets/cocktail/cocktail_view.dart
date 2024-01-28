import 'package:custom_cocktails/widgets/cocktail/cocktail_controller.dart';
import 'package:flutter/material.dart';

class CocktailView extends StatelessWidget {
  final CocktailController controller;

  const CocktailView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
        listenable: controller,
        builder: (BuildContext context, Widget? child) {
          if (controller.selectedCocktail == null) {
            return const CircularProgressIndicator(key: Key('loadingImage'));
          }
          return Text(controller.selectedCocktail!.recipe);
        });
  }
}
