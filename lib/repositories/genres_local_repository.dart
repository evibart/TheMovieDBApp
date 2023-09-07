import 'dart:convert';

import 'package:flutter/services.dart';

import '/data_classes/genre.dart';
import '/repositories_i/repository_i.dart';

class GenreLocalRepository implements IRepository<List<Genre>> {
  static const String _jsonGenresPath = 'mock_data/genres.json';

  @override
  Future<List<Genre>> loadData() async {
    final jsonData = jsonDecode(await rootBundle.loadString(_jsonGenresPath));
    final List<dynamic> genreList = jsonData['genres'];
    return genreList.map((genre) => Genre.fromJson(genre)).toList();
  }
}
