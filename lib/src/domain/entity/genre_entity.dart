import '../../data/model/genre_model.dart';

class GenreEntity {
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
  bool operator ==(Object other) =>
      other is GenreEntity && id == other.id && name == other.name;

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
