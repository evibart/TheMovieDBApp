import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../core/parameter/movie_screen_parameters.dart';
import '../../../core/util/constants.dart';
import '../../../domain/entity/movie_entity.dart';
import '../../view/movie_home_page.dart';

class MovieList extends StatelessWidget {
  final List<MovieEntity> moviesList;
  static const double movieBoxSize = 125;
  static const double titleSize = 20;
  static const int overviewMaxLines = 3;
  static const double elevationValue = 5;
  static const int crossAxisCount = 2;

  const MovieList({
    super.key,
    required this.moviesList,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        key: Key(Constants.gridViewKey),
        itemCount: moviesList.length,
        itemBuilder: (
          BuildContext context,
          int index,
        ) {
          return Card(
            elevation: elevationValue,
            margin: const EdgeInsets.symmetric(
              horizontal: Constants.paddingSize,
              vertical: Constants.paddingSize,
            ),
            child: InkWell(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: movieBoxSize,
                    width: movieBoxSize,
                    child: CachedNetworkImage(
                      imageUrl: moviesList[index].posterUrl,
                      progressIndicatorBuilder: (
                        BuildContext context,
                        String url,
                        DownloadProgress downloadProgress,
                      ) =>
                          CircularProgressIndicator(
                              value: downloadProgress.progress),
                      errorWidget: (
                        BuildContext context,
                        String url,
                        Object error,
                      ) =>
                          Icon(Icons.error),
                    ),
                  ),
                ],
              ),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  MovieHomePage.routeName,
                  arguments: ScreenArguments(
                    index: index,
                    movies: moviesList,
                  ),
                );
              },
            ),
          );
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount),
      ),
    );
  }
}
