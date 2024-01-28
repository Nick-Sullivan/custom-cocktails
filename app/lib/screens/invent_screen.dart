import 'package:custom_cocktails/widgets/invent/invent_controller.dart';
import 'package:custom_cocktails/widgets/invent/invent_view.dart';
import 'package:flutter/material.dart';

class InventScreen extends StatelessWidget {
  final controller = InventController();

  InventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return InventView(controller: controller);
    // return SingleChildScrollView(
    //   child: Column(
    //     children: <Widget>[
    //       InventView(controller: controller),
    //     ],
    //   ),
    // );
  }
}
