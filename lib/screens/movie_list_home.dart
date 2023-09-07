import 'package:flutter/material.dart';
import '/movie_list_widgets/movie_list.dart';
import '/repositories/movie_local_repository.dart';
import '/repositories_i/repository_i.dart';

import '/data_classes/movie.dart';

class MovieListHome extends StatefulWidget {
  const MovieListHome({super.key});

  static const String routeName = "/";

  @override
  State<StatefulWidget> createState() => _MovieListHomeState();
}

class _MovieListHomeState extends State<MovieListHome> {
  final IRepository<List<Movie>> movieRepository = MovieLocalRepository();
  late Future<List<Movie>> movies;

  @override
  initState() {
    super.initState();
    movies = movieRepository.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Movie>>(
        future: movies,
        builder: (
          BuildContext context,
          AsyncSnapshot<List<Movie>> snapshot,
        ) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                "${snapshot.error}",
              ),
            );
          } else if (snapshot.hasData) {
            return MovieList(
              moviesList: snapshot.data!,
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}