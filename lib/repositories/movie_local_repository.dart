import 'dart:convert';
import 'package:flutter/services.dart';

import '/repositories_i/repository_i.dart';
import '/data_classes/movie.dart';

class MovieLocalRepository implements IRepository<List<Movie>> {
  static const String _jsonMoviesPath = 'mock_data/movies.json';

  @override
  Future<List<Movie>> loadData() async {
    List<dynamic> movies =
        jsonDecode(await rootBundle.loadString(_jsonMoviesPath));
    return movies.map((movie) => Movie.fromJson(movie)).toList();
  }
}
