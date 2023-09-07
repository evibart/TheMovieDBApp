import 'package:flutter/material.dart';

import 'likes_rating.dart';
import '/data_classes/movie.dart';
import 'movie_genres.dart';
import 'movie_info.dart';

class MovieBody extends StatelessWidget {
  final Movie movie;

  const MovieBody({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
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
              releaseDate: movie.movieReleaseDate,
            ),
            LikeAndRating(
              voteAverage: movie.voteAverage,
            ),
            MovieGenres(
              movieGenres: movie.genres,
            ),
          ],
        ),
      ),
    );
  }
}
