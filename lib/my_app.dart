import 'package:flutter/material.dart';
import 'src/data/datasource/remote/api_service.dart';
import 'src/data/repository/movie_database_repository.dart';
import 'package:provider/provider.dart';
import 'src/domain/use_case/implementation/movie_use_case.dart';
import 'src/presentation/bloc/movie_bloc.dart';
import 'src/presentation/view/movie_home_page.dart';

import 'src/presentation/view/movie_list_home.dart';
import 'src/data/repository/movie_remote_repository.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
            create: (_) => MovieRemoteRepository(
                apiService: Provider.of<ApiService>(context,listen: false,))),
        Provider(
          create: (BuildContext context) => MovieUseCase(
            movieRepository: Provider.of<MovieRemoteRepository>(
              context,
              listen: false,
            ),
            movieDataBase: Provider.of<MovieDatabaseRepository>(context,listen: false,),
          ),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.deepOrange,
          brightness: Brightness.dark,
        ),
        initialRoute: MovieListHome.routeName,
        routes: {
          MovieListHome.routeName: (BuildContext context) => MovieListHome(
                movieBloc: MovieBloc(
                  moviesUseCase: Provider.of<MovieUseCase>(context,listen: false,),
                ),
              ),
          MovieHomePage.routeName: (BuildContext context) =>
              const MovieHomePage(),
        },
      ),
    );
  }
}
