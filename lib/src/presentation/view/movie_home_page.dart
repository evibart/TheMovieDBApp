import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/parameter/movie_screen_parameters.dart';
import '../../data/datasource/remote/api_service.dart';
import '../../data/repository/genre_database_repository.dart';
import '../../data/repository/genre_remote_repository.dart';
import '../../domain/entity/movie_entity.dart';
import '../../domain/use_case/implementation/genre_use_case.dart';
import '../widget/movie_info_screen/movie_app_bar.dart';
import '../widget/movie_info_screen/movie_body.dart';

class MovieHomePage extends StatelessWidget {
  const MovieHomePage({super.key});

  static const String routeName = "/movie";

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    final PageController _pageController = PageController(
      initialPage: args.index,
    );
    final List<MovieEntity> movies = args.movies;
    return MultiProvider(
        providers: [
          Provider(
              create: (_) => GenreRemoteRepository(
                  apiService: Provider.of<ApiService>(context))),
          Provider(
              create: (ctx) => GenreUseCase(
                  genreRepository: Provider.of<GenreRemoteRepository>(
                    ctx,
                    listen: false,
                  ),
                  genreDatabaseRepository:
                      Provider.of<GenreDatabaseRepository>(context))),
        ],
        child: PageView.builder(
          controller: _pageController,
          itemCount: movies.length,
          itemBuilder: (
            BuildContext context,
            int index,
          ) {
            return Scaffold(
              appBar: MovieAppBar(movieTitle: movies[index].title),
              body: MovieBody(movie: movies[index]),
            );
          },
        ));
  }
}
