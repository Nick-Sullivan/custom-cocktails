import 'package:custom_cocktails/infrastructure/cocktail_store.dart';
import 'package:custom_cocktails/models/cocktail.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class CocktailController extends ChangeNotifier {
  final store = GetIt.instance<CocktailStore>();
  bool _isInitialised = false;
  bool get isInitialised => _isInitialised;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  List<String> get cocktailIds => store.listSavedIds();
  String? _selectedId;
  String? get selectedId => _selectedId;
  Cocktail? _selectedCocktail;
  Cocktail? get selectedCocktail => _selectedCocktail;

  Future<void> loadCollection() async {
    _isLoading = true;
    _isInitialised = true;
    notifyListeners();
    final ids = await store.loadSavedIds();
    for (final id in ids) {
      await store.load(id);
    }
    _isLoading = false;
    _isInitialised = true;
    notifyListeners();
  }

  Future<void> setSelectedId(String id) async {
    _isLoading = true;
    _selectedId = null;
    notifyListeners();

    _selectedId = id;
    if (!store.hasLoaded(id)) {
      await store.load(id);
    }
    _selectedCocktail = store.get(id);
    _isLoading = false;
    notifyListeners();
  }

  Future<void> deleteSelectedCocktail() async {
    _isLoading = true;
    notifyListeners();

    await store.delete(_selectedId!);
    _selectedId = null;
    _selectedCocktail = null;
    _isLoading = false;
    notifyListeners();
  }

  Cocktail get(String id) {
    return store.get(id);
  }
}
