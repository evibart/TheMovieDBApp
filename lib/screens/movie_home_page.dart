import 'package:flutter/material.dart';
import '/movie_widgets/movie_app_bar.dart';
import '/movie_widgets/movie_body.dart';

import '/data_classes/movie.dart';

class MovieHomePage extends StatelessWidget {
  const MovieHomePage({super.key});

  static const String routeName = "/movie";

  @override
  Widget build(BuildContext context) {
    final movie = ModalRoute.of(context)!.settings.arguments as Movie;

    return Scaffold(
      appBar: MovieAppBar(movieTitle: movie.title),
      body: MovieBody(movie: movie),
    );
  }
}
