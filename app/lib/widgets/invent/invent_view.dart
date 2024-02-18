import 'package:custom_cocktails/widgets/invent/invent_controller.dart';
import 'package:flutter/material.dart';

class InventView extends StatelessWidget {
  final InventController controller;

  const InventView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
        listenable: controller,
        builder: (BuildContext context, Widget? child) {
          if (controller.notificationMessage != null) {
            final text = controller.notificationMessage!;
            WidgetsBinding.instance.addPostFrameCallback(
                (_) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(text),
                      key: const Key('notificationMessage'),
                    )));
            controller.clearNotification();
          }
          if (controller.isLoading) {
            return Stack(children: [
              createColumn(context),
              const Center(
                  child: CircularProgressIndicator(key: Key('loading'))),
            ]);
            // return const CircularProgressIndicator(key: Key('loading'));
          }
          return createColumn(context);
        });
  }

  Widget createColumn(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
              child: Column(children: [
            // Name
            Container(
              height: 80,
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: TextFormField(
                key: const Key("nameText"),
                controller: controller.nameController,
                enabled: !controller.isLoading,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Cocktail name",
                  prefixIcon: Icon(Icons.liquor_outlined),
                ),
              ),
            ),
            // Ingredients
            Container(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: TextFormField(
                key: const Key("ingredientsText"),
                enabled: !controller.isLoading,
                controller: controller.ingredientController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.check_circle_rounded),
                  labelText: "Ingredients to include (optional)",
                ),
                validator: (value) {
                  return null;
                },
              ),
            ),
            // Banned Ingredients
            Container(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: TextFormField(
                key: const Key("bannedText"),
                enabled: !controller.isLoading,
                controller: controller.bannedController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Ingredients to exclude (optional)",
                  prefixIcon: Icon(Icons.close_rounded),
                ),
                validator: (value) {
                  return null;
                },
              ),
            ),

            // Recipe
            Container(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: TextFormField(
                key: const Key("recipeText"),
                keyboardType: TextInputType.multiline,
                minLines: 10,
                maxLines: null,
                enabled: false,
                controller: controller.recipeController,
                textAlignVertical: TextAlignVertical.top,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Recipe",
                  alignLabelWithHint: true,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter some text";
                  }
                  if (value.length > 650) {
                    return "Too many characters";
                  }
                  return null;
                },
              ),
            ),
          ])),
        ),
        // Buttons
        SizedBox(
            height: 60,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    key: const Key("createButton"),
                    icon: const Icon(Icons.color_lens),
                    label: const Text('Invent'),
                    onPressed: controller.isLoading
                        ? null
                        : () async {
                            FocusScope.of(context).unfocus();
                            await controller.invent();
                          },
                  ),
                  ElevatedButton.icon(
                    key: const Key("saveButton"),
                    icon: const Icon(Icons.save),
                    label: const Text('Save'),
                    onPressed: controller.isLoading
                        ? null
                        : () async {
                            FocusScope.of(context).unfocus();
                            await controller.save();
                          },
                  )
                ])),
      ],
    );
  }
}
