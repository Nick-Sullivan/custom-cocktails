import 'dart:io';
import 'package:custom_cocktails/models/cocktail.dart';
import 'package:path_provider/path_provider.dart';

class CocktailStore {
  Directory? _dir;
  final Map<String, Cocktail> _cocktailsById = <String, Cocktail>{};
  final List<String> _cocktailIds = <String>[];

  Future<List<String>> loadSavedIds() async {
    final dir = await getDirectory();
    if (!dir.existsSync()) {
      dir.create();
      return <String>[];
    }
    final files = await dir.list().toList();
    _cocktailIds.clear();
    for (final file in files) {
      final qrId = getIdFromPath(file.path);
      if (!_cocktailIds.contains(qrId)) {
        _cocktailIds.add(qrId);
      }
    }
    return _cocktailIds;
  }

  Future<Cocktail> load(String id) async {
    final file = await getFile(id);
    final bytes = await file.readAsBytes();
    final qrCode = Cocktail.fromSerialised(bytes);
    _cocktailsById[id] = qrCode;
    return qrCode;
  }

  List<String> listSavedIds() {
    return _cocktailIds;
  }

  Cocktail get(String id) {
    return _cocktailsById[id]!;
  }

  Future<void> save(Cocktail cocktail) async {
    final file = await getFile(cocktail.id);
    await file.writeAsBytes(cocktail.serialise());
    _cocktailsById[cocktail.id] = cocktail;
    if (!_cocktailIds.contains(cocktail.id)) {
      _cocktailIds.add(cocktail.id);
    }
  }

  bool hasLoaded(String id) {
    return _cocktailsById.containsKey(id);
  }

  Future<void> delete(String id) async {
    final file = await getFile(id);
    await file.delete();
    _cocktailIds.removeWhere((i) => i == id);
    _cocktailsById.remove(id);
  }

  Future<Directory> getDirectory() async {
    if (_dir == null) {
      final dir = await getApplicationDocumentsDirectory();
      _dir = Directory("${dir.path}/cocktails");
    }
    return _dir!;
  }

  String getIdFromPath(String path) {
    return path.split("/").last.split("\\").last.split(".").first;
  }

  Future<File> getFile(String id) async {
    final dir = await getDirectory();
    return File("${dir.path}/$id.data");
  }
}
