import 'package:flutter/material.dart';
import '/custom_widgets/movie_body.dart';
import '/custom_widgets/movie_app_bar.dart';
import '/data_classes/movie.dart';

class MovieHomePage extends StatelessWidget {
  MovieHomePage({super.key});

  final Movie movie = Movie.defaultMovie();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MovieAppBar(movieTitle: movie.title),
      body: MovieBody(movie: movie),
    );
  }
}
