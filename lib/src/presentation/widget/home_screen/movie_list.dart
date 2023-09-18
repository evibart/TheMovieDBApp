import 'package:flutter/material.dart';

import '../../../core/util/constants.dart';
import '../../../domain/entity/movie.dart';
import '../../view/movie_home_page.dart';

class MovieList extends StatelessWidget {
  final List<Movie> moviesList;
  static const double movieBoxSize = 125;
  static const double titleSize = 20;
  static const int overviewMaxLines = 3;
  static const double elevationValue = 5;

  const MovieList({
    super.key,
    required this.moviesList,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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
          child: ElevatedButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: movieBoxSize,
                  width: movieBoxSize,
                  child: Image(
                    image: NetworkImage(
                      moviesList[index].posterUrl,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(
                      bottom: Constants.paddingSize,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(
                            Constants.paddingSize,
                          ),
                          child: Text(
                            moviesList[index].title,
                            style: const TextStyle(
                              fontSize: titleSize,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: Constants.paddingSize),
                          child: Text(
                            moviesList[index].overview,
                            maxLines: overviewMaxLines,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: Constants.paddingSize),
                          child: Text(
                            moviesList[index].voteAverage.toString(),
                            style: const TextStyle(
                              fontSize: Constants.textFont,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            onPressed: () {
              Navigator.pushNamed(
                context,
                MovieHomePage.routeName,
                arguments: moviesList[index],
              );
            },
          ),
        );
      },
    );
  }
}
