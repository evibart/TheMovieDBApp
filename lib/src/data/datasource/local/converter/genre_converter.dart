import 'dart:convert';

import 'package:floor/floor.dart';

import '../../../../domain/entity/genre_entity.dart';
import '../../../model/genre_model.dart';

class GenreConverter extends TypeConverter<List<GenreEntity>, String> {
  @override
  List<GenreEntity> decode(String databaseValue) {
    var json = jsonDecode(databaseValue) as List<dynamic>;
    return List<GenreEntity>.from(json
        .map((genre) => GenreModel.fromJson(genre))
        .map((genreModel) => GenreEntity.fromGenreModel(genreModel)));
  }

  @override
  String encode(List<GenreEntity> value) {
    return jsonEncode(value.map((genre) => genre.toJson()).toList());
  }
}
