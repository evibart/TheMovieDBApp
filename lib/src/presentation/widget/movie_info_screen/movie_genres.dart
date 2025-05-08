import 'package:flutter/material.dart';

import '../../../core/util/constants.dart';
import '../../../core/util/status.dart';
import '../../../domain/entity/data.dart';
import '../../../domain/entity/genre_entity.dart';
import '../../bloc/genre_bloc.dart';

class MovieGenres extends StatefulWidget {
  final List<int> movieGenres;
  final GenreBloc blocGenreList;

  const MovieGenres({
    super.key,
    required this.movieGenres,
    required this.blocGenreList,
  });

  List<String> linkGenres(List<GenreEntity> genresMap) {
    return genresMap
        .where((genre) => movieGenres.contains(genre.id))
        .map((genre) => genre.name)
        .toList();
  }

  @override
  State<StatefulWidget> createState() => _MovieGenresState();
}

class _MovieGenresState extends State<MovieGenres> {
  late Future<List<GenreEntity>> genresList;

  @override
  initState() {
    super.initState();
    widget.blocGenreList.fetchGenres();
  }

  @override
  void dispose() {
    widget.blocGenreList.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Data<List<GenreEntity>>>(
      initialData: widget.blocGenreList.initialData,
      stream: widget.blocGenreList.allGenres,
      builder: (
        BuildContext context,
        AsyncSnapshot<Data<List<GenreEntity>>> snapshot,
      ) {
        switch (snapshot.data!.state) {
          case Status.loading:
            return const Center(child: CircularProgressIndicator());
          case Status.failed:
            return Center(
              child: Text(
                snapshot.error.toString(),
              ),
            );
          case Status.success:
            List<String> genresList =
                widget.linkGenres(snapshot.data!.actualData!);
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (String genre in genresList)
                    Container(
                      padding: const EdgeInsets.all(
                        Constants.paddingSize,
                      ),
                      margin: const EdgeInsets.all(
                        Constants.paddingSize,
                      ),
                      child: Text(
                        genre,
                      ),
                    ),
                ],
              ),
            );
          case Status.empty:
            return Center(child: Text(Constants.emptyError));
        }
      },
    );
  }
}
