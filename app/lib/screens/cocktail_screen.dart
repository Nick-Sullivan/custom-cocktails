import 'package:custom_cocktails/widgets/cocktail/cocktail_controller.dart';
import 'package:custom_cocktails/widgets/cocktail/cocktail_view.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class CocktailScreen extends StatelessWidget {
  final controller = GetIt.instance<CocktailController>();
  CocktailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: buildBody(context),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(title: Text(controller.selectedCocktail!.name), actions: [
      PopupMenuButton(
          key: const Key("menuButton"),
          itemBuilder: (_) {
            var popMenus = [
              const PopupMenuItem(
                  value: 0,
                  child: Row(children: [Icon(Icons.delete), Text("Delete")]))
            ];
            return popMenus;
          },
          onSelected: ((value) {
            if (value == 0) {
              showDialog<String>(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: const Text('Delete?'),
                        content: const Text('This action cannot be undone.'),
                        actions: [
                          TextButton(
                            key: const Key('confirmDeleteButton'),
                            child: const Text('Delete'),
                            onPressed: () {
                              controller.deleteSelectedCocktail();
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: const Text('Cancel'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ));
            }
          })),
    ]);
  }

  Widget buildBody(BuildContext context) {
    return ListenableBuilder(
        listenable: controller,
        builder: (BuildContext context, Widget? child) {
          return SingleChildScrollView(
            child: CocktailView(
                controller: controller, key: const Key('cocktailView')),
          );
        });
  }
}
