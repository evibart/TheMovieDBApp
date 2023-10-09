import 'package:flutter/material.dart';
import 'src/domain/use_case/implementation/movie_use_case.dart';
import 'src/presentation/bloc/movie_bloc.dart';
import 'src/presentation/view/movie_home_page.dart';

import 'src/presentation/view/movie_list_home.dart';
import 'src/data/datasource/remote/api_service.dart';
import 'src/data/repository/movie_remote_repository.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ApiService apiService = ApiService();
    MovieRemoteRepository movieRepository =
        MovieRemoteRepository(apiService: apiService);
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.deepOrange,
        brightness: Brightness.dark,
      ),
      initialRoute: MovieListHome.routeName,
      routes: {
        MovieListHome.routeName: (context) => MovieListHome(
              movieBloc: MovieBloc(
                  moviesUseCase:
                      MovieUseCase(movieRepository: movieRepository)),
            ),
        MovieHomePage.routeName: (context) => const MovieHomePage(),
      },
    );
  }
}
