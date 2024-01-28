import 'package:custom_cocktails/widgets/cocktail/cocktail_list_view.dart';
import 'package:flutter/material.dart';

class CocktailListScreen extends StatelessWidget {
  const CocktailListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CocktailListView(
      key: const Key('collectionView'),
    );
  }
}
