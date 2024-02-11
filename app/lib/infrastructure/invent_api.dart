import 'dart:convert';
import 'package:custom_cocktails/models/cocktail.dart';
import 'package:http/http.dart' as http;

class InventApiInteractor {
  final String url;

  InventApiInteractor({required this.url});

  Future<Cocktail> invent(String name, String ingredients) async {
    final uri = Uri.parse('$url/invent');
    final request = '''{
      "name": "$name",
      "ingredients": "$ingredients",
      "banned_ingredients": "eggs"
    }''';
    return await sendRequest(uri, request);
  }

  Future<Cocktail> sendRequest(Uri uri, String request) async {
    final response = await http.post(uri, body: request);
    if (response.statusCode != 200) {
      throw Exception('uh oh');
    }
    final json = jsonDecode(response.body);
    final cocktail = Cocktail(
      name: json['name'],
      recipe: json['recipe'],
    );
    return cocktail;
  }
}
