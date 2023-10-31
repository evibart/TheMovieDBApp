import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/entity/movie_entity.dart';
import '../../../domain/use_case/implementation/genre_use_case.dart';
import '../../bloc/genre_bloc.dart';
import 'likes_rating.dart';
import 'movie_genres.dart';
import 'movie_info.dart';

class MovieBody extends StatelessWidget {
  final MovieEntity movie;

  const MovieBody({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Image(
                  image: NetworkImage(
                    movie.backdropUrl,
                  ),
                ),
                MovieInfo(
                  poster: movie.posterUrl,
                  originalTitle: movie.originalTitle,
                  overview: movie.overview,
                  releaseDate: movie.releaseDate,
                ),
                LikeAndRating(
                  voteAverage: movie.voteAverage,
                ),
                MovieGenres(
                    movieGenres: movie.genres,
                    blocGenreList: GenreBloc(genreUseCase: Provider.of<GenreUseCase>(context))),
              ],
            ),
          ),
        ),
      
    );
  }
}
