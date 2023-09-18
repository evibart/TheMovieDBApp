import 'dart:convert';
import 'package:flutter/services.dart';

import '../../domain/entity/movie.dart';
import '../../domain/repository/repository_i.dart';

class MovieLocalRepository implements IRepository<List<Movie>> {
  static const String _jsonMoviesPath = 'mock_data/movies.json';

  @override
  Future<List<Movie>> loadData() async {
    List<dynamic> movies =
        jsonDecode(await rootBundle.loadString(_jsonMoviesPath));
    return movies.map((movie) => Movie.fromJson(movie)).toList();
  }
}
