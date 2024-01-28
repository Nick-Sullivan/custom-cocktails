import 'package:custom_cocktails/infrastructure/cocktail_store.dart';
import 'package:custom_cocktails/screens/home_screen.dart';
import 'package:custom_cocktails/widgets/cocktail/cocktail_controller.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupSingletons();
  runApp(const MyApp());
}

Future<void> setupSingletons() async {
  GetIt.I.registerSingleton<CocktailStore>(CocktailStore());
  final collectionController = CocktailController();
  await collectionController.loadCollection();
  GetIt.I.registerSingleton<CocktailController>(collectionController);
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({super.key, this.initialRoute = '/ingredients'});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Custom Cocktails',
      initialRoute: initialRoute,
      // theme: createLightTheme(),
      // darkTheme: createDarkTheme(),
      routes: {
        '/ingredients': (context) => const HomeScreen(initialTab: 0),
      },
    );
  }
}
