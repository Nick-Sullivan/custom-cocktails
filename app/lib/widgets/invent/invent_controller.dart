import 'package:custom_cocktails/infrastructure/cocktail_store.dart';
import 'package:custom_cocktails/infrastructure/invent_api.dart';
import 'package:custom_cocktails/models/cocktail.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class InventController extends ChangeNotifier {
  final nameController = TextEditingController();
  final ingredientController = TextEditingController();
  final bannedController = TextEditingController();
  final recipeController = TextEditingController();
  final cocktailStore = GetIt.instance<CocktailStore>();
  final inventApi = GetIt.instance<InventApiInteractor>();

  String get name => nameController.text;
  String get bannedIngredients => bannedController.text;
  String get ingredients => ingredientController.text;
  String get recipe => recipeController.text;
  bool _isValid = false;
  bool get isValid => _isValid;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String? _notificationMessage;
  String? get notificationMessage => _notificationMessage;

  void setValid(bool value) {
    if (value == _isValid) {
      return;
    }
    _isValid = value;
    notifyListeners();
  }

  Future<void> invent() async {
    _isLoading = true;
    notifyListeners();

    final cocktail =
        await inventApi.invent(name, ingredients, bannedIngredients);
    nameController.text = cocktail.name;
    recipeController.text = cocktail.recipe;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> save() async {
    final cocktail = Cocktail(name: name, recipe: recipe);
    await cocktailStore.save(cocktail);
    _notificationMessage = "Saved your cocktail.";
    notifyListeners();
  }

  void clearNotification() {
    _notificationMessage = null;
  }
}
