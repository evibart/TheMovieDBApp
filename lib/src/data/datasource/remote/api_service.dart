import 'dart:convert';
import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:http/http.dart' as http;

import '../../../core/util/either_response.dart';
import '../../../domain/entity/genre_entity.dart';
import '../../../domain/entity/movie_entity.dart';
import '../../model/genre_model.dart';
import '../../model/movie_model.dart';

class ApiService {
  static const String apiKey = '?api_key=802b2c4b88ea1183e50e6b285a27696e';

  EitherResponse<List<MovieEntity>> getMovies(String url) async {
    try {
      final http.Response response = await http.get(Uri.parse('$url$apiKey'));
      if (response.statusCode == HttpStatus.ok) {
        return Right((jsonDecode(response.body)['results'] as List<dynamic>)
            .map((data) => MovieModel.fromJson(data))
            .map((movieModel) => MovieEntity.fromMovieModel(movieModel: movieModel))
            .toList());
      } else {
        throw Exception('${response.statusCode} ${response.body}');
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  EitherResponse<List<GenreEntity>> getGenres(String url) async {
    try {
      final http.Response response = await http.get(Uri.parse('$url$apiKey'));
      if (response.statusCode == HttpStatus.ok) {
        final List<dynamic> genreDataList = jsonDecode(response.body)['genres'];
        List<GenreEntity> genres = genreDataList
            .map((data) => GenreModel.fromJson(data))
            .map((genreModel) => GenreEntity.fromGenreModel(genreModel))
            .toList();
        return Right(genres);
      } else {
        throw Exception('${response.statusCode} ${response.body}');
      }
    } catch (e) {
      return Left(e.toString());
    }
  }
}
