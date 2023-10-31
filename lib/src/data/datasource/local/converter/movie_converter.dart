import 'dart:convert';

import 'package:floor/floor.dart';

import '../../../../domain/entity/movie_entity.dart';
import '../../../model/movie_model.dart';

class MovieConverter extends TypeConverter<List<MovieEntity>, String> {
  @override
  List<MovieEntity> decode(String databaseValue) {
    var json = jsonDecode(databaseValue) as List<dynamic>;
    return List<MovieEntity>.from(json
        .map((movie) => MovieModel.fromJson(movie))
        .map((movieModel) =>
            MovieEntity.fromMovieModel(movieModel: movieModel)));
  }

  @override
  String encode(List<MovieEntity> value) {
    return jsonEncode(value.map((movie) => movie.toJson()).toList());
  }
}
