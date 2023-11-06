import 'package:flutter/material.dart';
import 'src/core/util/constants.dart';
import 'splash_screen.dart';
import 'src/data/datasource/local/app_database.dart';
import 'src/data/datasource/remote/api_service.dart';
import 'src/data/repository/genre_database_repository.dart';
import 'src/data/repository/movie_database_repository.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final AppDataBase database =
      await $FloorAppDataBase.databaseBuilder(Constants.databaseName).build();
  runApp(MultiProvider(providers: [
    Provider(create: (_) => ApiService()),
    Provider(create: (_) => MovieDatabaseRepository(appDataBase: database)),
    Provider(create: (_) => GenreDatabaseRepository(appDataBase: database)),
  ], child: MaterialApp(home: SplashScreen())));
}
