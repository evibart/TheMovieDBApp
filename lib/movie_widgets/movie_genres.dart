import 'package:flutter/material.dart';
import '/repositories_i/repository_i.dart';
import '/data_classes/genre.dart';
import '/constants/constants.dart';

import '/repositories/genres_local_repository.dart';

class MovieGenres extends StatefulWidget {
  final List<int> movieGenres;

  const MovieGenres({
    super.key,
    required this.movieGenres,
  });

  List<String> linkGenres(List<Genre> genresMap) {
    return genresMap
        .where((genre) => movieGenres.contains(genre.id))
        .map((genre) => genre.name)
        .toList();
  }

  @override
  State<StatefulWidget> createState() => _MovieGenresState();
}

class _MovieGenresState extends State<MovieGenres> {
  final IRepository<List<Genre>> genreRepository = GenreLocalRepository();
  late Future<List<Genre>> genresList;

  @override
  initState() {
    super.initState();
    genresList = genreRepository.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Genre>>(
      future: genresList,
      builder: (
        BuildContext context,
        AsyncSnapshot<List<Genre>> snapshot,
      ) {
        if (snapshot.hasError) {
          return Center(
            child: Text(
              "${snapshot.error}",
            ),
          );
        } else if (snapshot.hasData) {
          List<String> genresList = widget.linkGenres(snapshot.data!);
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (String genre in genresList)
                  Container(
                    padding: const EdgeInsets.all(
                      Constants.paddingSize,
                    ),
                    margin: const EdgeInsets.all(
                      Constants.paddingSize,
                    ),
                    child: Text(
                      genre,
                    ),
                  ),
              ],
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
