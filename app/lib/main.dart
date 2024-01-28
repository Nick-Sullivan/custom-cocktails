import 'package:custom_cocktails/infrastructure/cocktail_store.dart';
import 'package:custom_cocktails/screens/home_screen.dart';
import 'package:custom_cocktails/widgets/cocktail/cocktail_controller.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
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
      theme: createLightTheme(),
      darkTheme: createDarkTheme(),
      routes: {
        '/ingredients': (context) => const HomeScreen(initialTab: 0),
      },
    );
  }

  ThemeData createLightTheme() {
    return FlexThemeData.light(
      scheme: FlexScheme.hippieBlue,
      usedColors: 7,
      surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
      blendLevel: 4,
      appBarStyle: FlexAppBarStyle.background,
      bottomAppBarElevation: 1.0,
      subThemesData: const FlexSubThemesData(
        blendOnLevel: 10,
        blendOnColors: false,
        blendTextTheme: true,
        useTextTheme: true,
        useM2StyleDividerInM3: true,
        thickBorderWidth: 2.0,
        elevatedButtonSchemeColor: SchemeColor.onPrimaryContainer,
        elevatedButtonSecondarySchemeColor: SchemeColor.primaryContainer,
        inputDecoratorSchemeColor: SchemeColor.primary,
        inputDecoratorBackgroundAlpha: 12,
        inputDecoratorRadius: 8.0,
        inputDecoratorUnfocusedHasBorder: false,
        inputDecoratorPrefixIconSchemeColor: SchemeColor.primary,
        useInputDecoratorThemeInDialogs: true,
        appBarScrolledUnderElevation: 8.0,
        drawerElevation: 1.0,
        drawerWidth: 290.0,
        bottomNavigationBarSelectedLabelSchemeColor: SchemeColor.secondary,
        bottomNavigationBarMutedUnselectedLabel: false,
        bottomNavigationBarSelectedIconSchemeColor: SchemeColor.secondary,
        bottomNavigationBarMutedUnselectedIcon: false,
        navigationBarSelectedLabelSchemeColor: SchemeColor.onSecondaryContainer,
        navigationBarSelectedIconSchemeColor: SchemeColor.onSecondaryContainer,
        navigationBarIndicatorSchemeColor: SchemeColor.secondaryContainer,
        navigationBarIndicatorOpacity: 1.00,
        navigationBarElevation: 1.0,
        navigationBarHeight: 72.0,
        navigationRailSelectedLabelSchemeColor:
            SchemeColor.onSecondaryContainer,
        navigationRailSelectedIconSchemeColor: SchemeColor.onSecondaryContainer,
        navigationRailIndicatorSchemeColor: SchemeColor.secondaryContainer,
        navigationRailIndicatorOpacity: 1.00,
      ),
      keyColors: const FlexKeyColors(),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      useMaterial3: true,
      // To use the Playground font, add GoogleFonts package and uncomment
      // fontFamily: GoogleFonts.notoSans().fontFamily,
    );
  }

  ThemeData createDarkTheme() {
    return FlexThemeData.dark(
      scheme: FlexScheme.hippieBlue,
      usedColors: 7,
      surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
      blendLevel: 10,
      appBarStyle: FlexAppBarStyle.background,
      bottomAppBarElevation: 2.0,
      subThemesData: const FlexSubThemesData(
        blendOnLevel: 20,
        blendTextTheme: true,
        useTextTheme: true,
        useM2StyleDividerInM3: true,
        thickBorderWidth: 2.0,
        elevatedButtonSchemeColor: SchemeColor.onPrimaryContainer,
        elevatedButtonSecondarySchemeColor: SchemeColor.primaryContainer,
        inputDecoratorSchemeColor: SchemeColor.primary,
        inputDecoratorBackgroundAlpha: 48,
        inputDecoratorRadius: 8.0,
        inputDecoratorUnfocusedHasBorder: false,
        inputDecoratorPrefixIconSchemeColor: SchemeColor.primary,
        useInputDecoratorThemeInDialogs: true,
        drawerElevation: 1.0,
        drawerWidth: 290.0,
        bottomNavigationBarSelectedLabelSchemeColor: SchemeColor.secondary,
        bottomNavigationBarMutedUnselectedLabel: false,
        bottomNavigationBarSelectedIconSchemeColor: SchemeColor.secondary,
        bottomNavigationBarMutedUnselectedIcon: false,
        navigationBarSelectedLabelSchemeColor: SchemeColor.onSecondaryContainer,
        navigationBarSelectedIconSchemeColor: SchemeColor.onSecondaryContainer,
        navigationBarIndicatorSchemeColor: SchemeColor.secondaryContainer,
        navigationBarIndicatorOpacity: 1.00,
        navigationBarElevation: 1.0,
        navigationBarHeight: 72.0,
        navigationRailSelectedLabelSchemeColor:
            SchemeColor.onSecondaryContainer,
        navigationRailSelectedIconSchemeColor: SchemeColor.onSecondaryContainer,
        navigationRailIndicatorSchemeColor: SchemeColor.secondaryContainer,
        navigationRailIndicatorOpacity: 1.00,
      ),
      keyColors: const FlexKeyColors(),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      useMaterial3: true,
      // To use the Playground font, add GoogleFonts package and uncomment
      // fontFamily: GoogleFonts.notoSans().fontFamily,
    );
  }
}
