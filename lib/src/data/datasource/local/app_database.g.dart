// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDataBase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDataBaseBuilder databaseBuilder(String name) =>
      _$AppDataBaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDataBaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDataBaseBuilder(null);
}

class _$AppDataBaseBuilder {
  _$AppDataBaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDataBaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDataBaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDataBase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDataBase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDataBase extends AppDataBase {
  _$AppDataBase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  MovieDao? _movieDaoInstance;

  GenreDao? _genreDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `MovieEntity` (`id` INTEGER NOT NULL, `title` TEXT NOT NULL, `originalTitle` TEXT NOT NULL, `overview` TEXT NOT NULL, `releaseDate` TEXT NOT NULL, `voteAverage` REAL NOT NULL, `genres` TEXT NOT NULL, `poster` TEXT NOT NULL, `backdrop` TEXT NOT NULL, `originalLanguage` TEXT NOT NULL, `popularity` REAL NOT NULL, `hasVideo` INTEGER NOT NULL, `voteCount` INTEGER NOT NULL, `isAdult` INTEGER NOT NULL, `categories` TEXT NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `GenreEntity` (`id` INTEGER NOT NULL, `name` TEXT NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  MovieDao get movieDao {
    return _movieDaoInstance ??= _$MovieDao(database, changeListener);
  }

  @override
  GenreDao get genreDao {
    return _genreDaoInstance ??= _$GenreDao(database, changeListener);
  }
}

class _$MovieDao extends MovieDao {
  _$MovieDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _movieEntityInsertionAdapter = InsertionAdapter(
            database,
            'MovieEntity',
            (MovieEntity item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'originalTitle': item.originalTitle,
                  'overview': item.overview,
                  'releaseDate': item.releaseDate,
                  'voteAverage': item.voteAverage,
                  'genres': _intListConverter.encode(item.genres),
                  'poster': item.poster,
                  'backdrop': item.backdrop,
                  'originalLanguage': item.originalLanguage,
                  'popularity': item.popularity,
                  'hasVideo': item.hasVideo ? 1 : 0,
                  'voteCount': item.voteCount,
                  'isAdult': item.isAdult ? 1 : 0,
                  'categories': _stringListConverter.encode(item.categories)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<MovieEntity> _movieEntityInsertionAdapter;

  @override
  Future<List<MovieEntity>> getMovies(String category) async {
    return _queryAdapter.queryList(
        'SELECT * FROM MovieEntity where categories LIKE \'%\' || ?1 || \'%\'',
        mapper: (Map<String, Object?> row) => MovieEntity(
            id: row['id'] as int,
            title: row['title'] as String,
            originalTitle: row['originalTitle'] as String,
            overview: row['overview'] as String,
            releaseDate: row['releaseDate'] as String,
            voteAverage: row['voteAverage'] as double,
            genres: _intListConverter.decode(row['genres'] as String),
            poster: row['poster'] as String,
            backdrop: row['backdrop'] as String,
            originalLanguage: row['originalLanguage'] as String,
            popularity: row['popularity'] as double,
            hasVideo: (row['hasVideo'] as int) != 0,
            voteCount: row['voteCount'] as int,
            isAdult: (row['isAdult'] as int) != 0,
            categories:
                _stringListConverter.decode(row['categories'] as String)),
        arguments: [category]);
  }

  @override
  Future<MovieEntity?> findMovieById(int id) async {
    return _queryAdapter.query('SELECT * FROM MovieEntity WHERE id = ?1',
        mapper: (Map<String, Object?> row) => MovieEntity(
            id: row['id'] as int,
            title: row['title'] as String,
            originalTitle: row['originalTitle'] as String,
            overview: row['overview'] as String,
            releaseDate: row['releaseDate'] as String,
            voteAverage: row['voteAverage'] as double,
            genres: _intListConverter.decode(row['genres'] as String),
            poster: row['poster'] as String,
            backdrop: row['backdrop'] as String,
            originalLanguage: row['originalLanguage'] as String,
            popularity: row['popularity'] as double,
            hasVideo: (row['hasVideo'] as int) != 0,
            voteCount: row['voteCount'] as int,
            isAdult: (row['isAdult'] as int) != 0,
            categories:
                _stringListConverter.decode(row['categories'] as String)),
        arguments: [id]);
  }

  @override
  Future<void> saveMovie(MovieEntity movie) async {
    await _movieEntityInsertionAdapter.insert(
        movie, OnConflictStrategy.replace);
  }
}

class _$GenreDao extends GenreDao {
  _$GenreDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _genreEntityInsertionAdapter = InsertionAdapter(
            database,
            'GenreEntity',
            (GenreEntity item) =>
                <String, Object?>{'id': item.id, 'name': item.name});

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<GenreEntity> _genreEntityInsertionAdapter;

  @override
  Future<List<GenreEntity>> getGenres() async {
    return _queryAdapter.queryList('SELECT * From GenreEntity',
        mapper: (Map<String, Object?> row) =>
            GenreEntity(id: row['id'] as int, name: row['name'] as String));
  }

  @override
  Future<GenreEntity?> findGenreById(int id) async {
    return _queryAdapter.query('SELECT * FROM GenreEntity WHERE id = ?1',
        mapper: (Map<String, Object?> row) =>
            GenreEntity(id: row['id'] as int, name: row['name'] as String),
        arguments: [id]);
  }

  @override
  Future<void> saveGenre(GenreEntity genre) async {
    await _genreEntityInsertionAdapter.insert(
        genre, OnConflictStrategy.replace);
  }
}

// ignore_for_file: unused_element
final _genreConverter = GenreConverter();
final _movieConverter = MovieConverter();
final _intListConverter = IntListConverter();
final _stringListConverter = StringListConverter();
