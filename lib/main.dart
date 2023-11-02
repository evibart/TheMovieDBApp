import 'package:flutter/material.dart';
import 'package:movie_db_app/splash_screen.dart';
import 'package:movie_db_app/src/data/datasource/local/app_database.dart';
import 'package:movie_db_app/src/data/datasource/remote/api_service.dart';
import 'package:movie_db_app/src/data/repository/genre_database_repository.dart';
import 'package:movie_db_app/src/data/repository/movie_database_repository.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final AppDataBase database =
      await $FloorAppDataBase.databaseBuilder('my_database.db').build();
  runApp(MultiProvider(providers: [
    Provider(create: (_) => ApiService()),
    Provider(create: (_) => MovieDatabaseRepository(appDataBase: database)),
    Provider(create: (_) => GenreDatabaseRepository(appDataBase: database)),
  ], child: MaterialApp(home: SplashScreen())));
}
