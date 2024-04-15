import 'package:flutter/foundation.dart';
import '../models/character.dart';
import '../repositories/character_repository.dart';

class CharacterProvider extends ChangeNotifier {
  final CharacterRepository _characterRepository;

  List<Character> characters = [];
  int currentPage = 1;
  bool hasMore = true;

  CharacterProvider(this._characterRepository);

  Future<void> fetchCharacters() async {
    if (!hasMore) return;

    final newCharacters = await _characterRepository.fetchCharacters(currentPage);

    if (newCharacters.isEmpty) {

      hasMore = false;

    } else {

      characters.addAll(newCharacters);
      currentPage++;

    }

    notifyListeners();
  }
}