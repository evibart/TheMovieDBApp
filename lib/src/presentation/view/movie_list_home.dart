import 'package:flutter/material.dart';

import '../../core/util/movie_enum.dart';
import '../../domain/entity/movie_entity.dart';
import '../bloc/movie_bloc.dart';
import '../widget/home_screen/movie_list.dart';
import '../widget/home_screen/movie_list_appbar.dart';

class MovieListHome extends StatefulWidget {
  const MovieListHome({
    super.key,
    required this.movieBloc,
  });

  static const String routeName = "/";
  final MovieBloc movieBloc;

  @override
  State<StatefulWidget> createState() => _MovieListHomeState();
}

class _MovieListHomeState extends State<MovieListHome> {
  MovieEndpoint _movieEndpoint = MovieEndpoint.popular;
  static const String drawerTitle = 'Movies';

  void _onDrawerItemTap(MovieEndpoint movieEndpoint) {
    setState(() {
      _movieEndpoint = movieEndpoint;
      widget.movieBloc.fetchMovies(_movieEndpoint);
      Navigator.pop(context);
    });
  }

  @override
  initState() {
    super.initState();
    widget.movieBloc.fetchMovies(_movieEndpoint);
  }

  @override
  void dispose() {
    widget.movieBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MovieListAppBar(
        pageTitle: _movieEndpoint,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(child: Text(drawerTitle)),
            ListTile(
              title: Text(MovieEndpoint.popular.title),
              key: Key(MovieEndpoint.popular.key),
              onTap: () => _onDrawerItemTap(MovieEndpoint.popular),
            ),
            ListTile(
              title: Text(MovieEndpoint.topRated.title),
              key: Key(MovieEndpoint.topRated.key),
              onTap: () => _onDrawerItemTap(MovieEndpoint.topRated),
            ),
            ListTile(
              title: Text(MovieEndpoint.nowPlaying.title),
              key: Key(MovieEndpoint.nowPlaying.key),
              onTap: () => _onDrawerItemTap(MovieEndpoint.nowPlaying),
            ),
            ListTile(
              title: Text(MovieEndpoint.upComing.title),
              key: Key(MovieEndpoint.upComing.key),
              onTap: () => _onDrawerItemTap(MovieEndpoint.upComing),
            ),
          ],
        ),
      ),
      body: StreamBuilder<List<MovieEntity>>(
        stream: widget.movieBloc.allMovies,
        builder: (
          BuildContext context,
          AsyncSnapshot<List<MovieEntity>> snapshot,
        ) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            return MovieList(
              moviesList: snapshot.data!,
            );
          }
          return Center(
            child: Text(
              snapshot.error.toString(),
            ),
          );
        },
      ),
    );
  }
}
