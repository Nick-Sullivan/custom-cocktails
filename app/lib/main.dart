import 'package:custom_cocktails/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  MyApp({super.key, this.initialRoute = '/ingredients'});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Custom Cocktails',
      initialRoute: initialRoute,
      // theme: createLightTheme(),
      // darkTheme: createDarkTheme(),
      routes: {
        '/ingredients': (context) => HomeScreen(initialTab: 0),
      },
    );
  }
}
