import 'package:custom_cocktails/screens/cocktail_screen.dart';
import 'package:custom_cocktails/widgets/cocktail/cocktail_controller.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class CocktailListView extends StatelessWidget {
  final controller = GetIt.instance<CocktailController>();

  CocktailListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
        listenable: controller,
        builder: (BuildContext context, Widget? child) {
          if (controller.isLoading) {
            return const CircularProgressIndicator(key: Key('loadingImage'));
          }
          return ListView.builder(
              itemBuilder: _buildItem,
              itemCount: controller.cocktailIds.length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true);
        });
  }

  Widget _buildItem(BuildContext context, int index) {
    final id = controller.cocktailIds[index];
    return ListTile(
      title: Text(controller.get(id).name),
      trailing: const Icon(Icons.arrow_forward),
      onTap: () async {
        controller.setSelectedId(id);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => CocktailScreen()));
      },
    );
  }
}
