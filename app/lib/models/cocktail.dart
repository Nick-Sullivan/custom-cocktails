import 'dart:convert';

class Cocktail {
  final String id;
  final String name;
  final String recipe;

  const Cocktail({
    required this.id,
    required this.name,
    required this.recipe,
  });

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
