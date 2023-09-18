import 'package:flutter/material.dart';

import '../../domain/entity/movie.dart';
import '../widget/movie_info_screen/movie_app_bar.dart';
import '../widget/movie_info_screen/movie_body.dart';


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
