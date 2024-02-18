import 'package:custom_cocktails/screens/cocktail_edit_screen.dart';
import 'package:custom_cocktails/widgets/cocktail/cocktail_controller.dart';
import 'package:custom_cocktails/widgets/cocktail/cocktail_list_view.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class CocktailListScreen extends StatelessWidget {
  final controller = GetIt.instance<CocktailController>();
  CocktailListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CocktailListView(
        key: const Key('collectionView'),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CocktailEditScreen()));
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
