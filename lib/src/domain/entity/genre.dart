class Genre {
  final int id;
  final String name;

  Genre({
    required this.id,
    required this.name,
  });

  factory Genre.fromJson(Map<String, dynamic> genreJson) {
    return Genre(
      id: genreJson["id"],
      name: genreJson["name"],
    );
  }
}
