import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/character.dart';

class CharacterRepository {
  final String apiUrl = 'https://rickandmortyapi.com/api/character';

  Future<List<Character>> fetchCharacters(int page) async {
    final response = await http.get(Uri.parse('$apiUrl?page=$page'));

    if (response.statusCode == 200) {

      final data = jsonDecode(response.body);
      final results = data['results'] as List<dynamic>;

      return results.map((characterData) => Character.fromJson(characterData)).toList();

    } else {
      throw Exception('Failed to fetch characters');
    }
  }
}