import '../../domain/entity/movie_entity.dart';

class ScreenArguments {
  final int index;
  final List<MovieEntity> movies;

  ScreenArguments({
    required this.index,
    required this.movies,
  });
}
