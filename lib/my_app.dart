import 'package:flutter/material.dart';
import '/src/presentation/view/movie_home_page.dart';
import '/src/presentation/view/movie_list_home.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.deepOrange,
        brightness: Brightness.dark,
      ),
      initialRoute: MovieListHome.routeName,
      routes: {
        MovieListHome.routeName: (context) => const MovieListHome(),
        MovieHomePage.routeName: (context) => const MovieHomePage(),
      },
    );
  }
}
