import 'package:custom_cocktails/models/cocktail.dart';
import 'package:custom_cocktails/widgets/cocktail/cocktail_controller.dart';
import 'package:flutter/material.dart';

class CocktailEditView extends StatelessWidget {
  final CocktailController controller;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController recipeController = TextEditingController();

  CocktailEditView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
        listenable: controller,
        builder: (BuildContext context, Widget? child) {
          return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            // Name and Add button
            Container(
              padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
              child: Row(children: [
                Expanded(
                    child: TextField(
                  controller: nameController,
                  autofocus: true,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Name",
                      prefixIcon: Icon(Icons.liquor_outlined),
                      contentPadding: EdgeInsets.all(20.0)),
                )),
                ElevatedButton(
                    onPressed: () async {
                      final navigator = Navigator.of(context);
                      final cocktail = Cocktail(
                          name: nameController.text,
                          recipe: recipeController.text);
                      await controller.add(cocktail);
                      navigator.pop();
                    },
                    child: const Text("Add"))
              ]),
            ),
            // Recipe
            Container(
                padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                child: TextField(
                  controller: recipeController,
                  autofocus: true,
                  keyboardType: TextInputType.multiline,
                  minLines: 15,
                  maxLines: null,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Recipe",
                      // prefixIcon: Icon(Icons.qr_code_2),
                      alignLabelWithHint: true,
                      contentPadding: EdgeInsets.all(20.0)),
                ))
          ]);
          // return Text(controller.cocktail.name);
        });
  }
}
