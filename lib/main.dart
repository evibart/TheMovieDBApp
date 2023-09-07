import 'package:flutter/material.dart';
import '/screens/movie_home_page.dart';
import 'screens/movie_list_home.dart';

void main() => runApp(const MyApp());

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
