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
          return createColumn(context);
        });
  }

  Widget createColumn(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
              child: Column(children: [
            Container(
              height: 80,
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: TextFormField(
                key: const Key("nameText"),
                controller: controller.nameController,
                autofocus: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Cocktail name",
                  prefixIcon: Icon(Icons.liquor_outlined),
                  // contentPadding: EdgeInsets.fromLTRB(20, 0, 20, 0)
                ),
                // validator: (value) {},
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: TextFormField(
                key: const Key("recipeText"),
                keyboardType: TextInputType.multiline,
                minLines: 15,
                maxLines: null,
                controller: controller.recipeController,
                textAlignVertical: TextAlignVertical.top,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText:
                      "Type in a recipe, and use 'Suggest' to improve it",
                  alignLabelWithHint: true,
                  // prefixIcon: Icon(Icons.textsms),
                  // contentPadding: EdgeInsets.all(20.0)
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
            )
          ])),
        ),
        SizedBox(
            height: 60,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    key: const Key("createButton"),
                    icon: const Icon(Icons.sports_basketball_rounded),
                    label: const Text('Suggest'),
                    onPressed: () async {
                      FocusScope.of(context).unfocus();
                      // final gifId = await controller.createGif(context);
                      // if (gifId != null) {
                      //   qrCodeController.createGif(
                      //       gifId, controller.text);
                      // }
                    },
                  ),
                  ElevatedButton.icon(
                    key: const Key("saveButton"),
                    icon: const Icon(Icons.save),
                    label: const Text('Save'),
                    onPressed: () async {
                      FocusScope.of(context).unfocus();
                      await controller.save();
                    },
                  )
                ])),
      ],
    );
  }
}
