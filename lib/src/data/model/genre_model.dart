import 'package:movie_db_app/src/domain/entity/genre_entity.dart';

class GenreModel extends GenreEntity{

  GenreModel({
    required int id,
    required String name,
  }) : super(
    id: id,
    name: name,
  );
  factory GenreModel.fromJson(Map<String, dynamic> genreJson) {
    return GenreModel(
      id: genreJson["id"],
      name: genreJson["name"],
    );
  }
}
