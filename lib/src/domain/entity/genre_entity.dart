import 'package:floor/floor.dart';
import 'package:json_class/json_class.dart';

import '../../data/model/genre_model.dart';

@entity
class GenreEntity extends JsonClass {
  @primaryKey
  final int id;
  final String name;

  GenreEntity({
    required this.id,
    required this.name,
  });

  factory GenreEntity.fromGenreModel(GenreModel genreModel) {
    return GenreEntity(
      id: genreModel.id,
      name: genreModel.name,
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };

  @override
  bool operator ==(Object other) =>
      other is GenreEntity && id == other.id && name == other.name;

  @override
  int get hashCode => id.hashCode;
}
