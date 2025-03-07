import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'src/domain/use_case/implementation/movie_use_case.dart';
import 'src/presentation/bloc/movie_bloc.dart';
import 'src/presentation/view/movie_home_page.dart';

import 'src/presentation/view/movie_list_home.dart';

class MyApp extends ConsumerWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.deepOrange,
        brightness: Brightness.dark,
      ),
      initialRoute: MovieListHome.routeName,
      routes: {
        MovieListHome.routeName: (BuildContext context) => MovieListHome(
              movieBloc: MovieBloc(moviesUseCase: ref.watch(movieUseCaseProvider)),
            ),
        MovieHomePage.routeName: (BuildContext context) =>
            const MovieHomePage(),
      },
    );
  }
}
