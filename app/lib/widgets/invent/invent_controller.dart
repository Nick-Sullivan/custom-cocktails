import 'package:custom_cocktails/infrastructure/cocktail_store.dart';
import 'package:custom_cocktails/models/cocktail.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:uuid/uuid.dart';

class InventController extends ChangeNotifier {
  final nameController = TextEditingController();
  final recipeController = TextEditingController();
  final cocktailStore = GetIt.instance<CocktailStore>();
  final uuid = const Uuid();

  String get name => nameController.text;
  String get recipe => recipeController.text;
  bool _isValid = false;
  bool get isValid => _isValid;
  String? _notificationMessage;
  String? get notificationMessage => _notificationMessage;

  void setValid(bool value) {
    if (value == _isValid) {
      return;
    }
    _isValid = value;
    notifyListeners();
  }

  Future<void> save() async {
    final cocktail = Cocktail(id: uuid.v4(), name: name, recipe: recipe);
    await cocktailStore.save(cocktail);
    _notificationMessage = "Saved your cocktail.";
    notifyListeners();
  }

  void clearNotification() {
    _notificationMessage = null;
  }
}
