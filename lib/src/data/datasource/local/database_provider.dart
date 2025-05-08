import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/util/constants.dart';
import 'app_database.dart';

class DatabaseNotifier extends StateNotifier<DatabaseState> {
  AppDataBase? _database;

  DatabaseNotifier() : super(DatabaseState.loading);

  Future<void> initializeDatabase() async {
    _database =
    await $FloorAppDataBase.databaseBuilder(Constants.databaseName).build();
    state = DatabaseState.ready;
  }

  AppDataBase? get database => _database;
}

final databaseProvider =
StateNotifierProvider<DatabaseNotifier, DatabaseState>((ref) {
  return DatabaseNotifier();
});

enum DatabaseState {
  loading,
  ready,
}