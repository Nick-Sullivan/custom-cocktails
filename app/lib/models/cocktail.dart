import 'dart:convert';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Cocktail {
  final String id;
  final String name;
  final String recipe;

  factory Cocktail({required String name, required String recipe, String? id}) {
    return Cocktail._(name: name, recipe: recipe, id: id ?? uuid.v4());
  }

  Cocktail._({required this.name, required this.recipe, required this.id});

  List<int> serialise() {
    final json = jsonEncode({"id": id, "name": name, "recipe": recipe});
    final serialised = utf8.encode(json);
    return serialised;
  }

  factory Cocktail.fromSerialised(List<int> metadata) {
    final json = utf8.decode(metadata);
    final Map map = jsonDecode(json);
    return Cocktail(
      id: map['id'],
      name: map['name'],
      recipe: map['recipe'],
    );
  }
}
