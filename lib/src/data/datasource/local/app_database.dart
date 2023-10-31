import 'dart:async';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'package:floor/floor.dart';
import 'package:movie_db_app/src/data/datasource/local/dao/genre_dao.dart';

import '../../../domain/entity/genre_entity.dart';
import '../../../domain/entity/movie_entity.dart';
import 'converter/genre_converter.dart';
import 'converter/int_converter.dart';
import 'converter/movie_converter.dart';
import 'converter/string_converter.dart';
import 'dao/movies_dao.dart';

part 'app_database.g.dart';

@TypeConverters([
  GenreConverter,
  MovieConverter,
  IntListConverter,
  StringListConverter,
])
@Database(
  version: 1,
  entities: [
    MovieEntity,
    GenreEntity,
  ],
)
abstract class AppDataBase extends FloorDatabase {
  MovieDao get movieDao;

  GenreDao get genreDao;
}
