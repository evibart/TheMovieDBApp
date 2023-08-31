import 'package:flutter/material.dart';

import '/constants/constants.dart';

class MovieGenres extends StatelessWidget {
  final List<String> movieGenres;

  const MovieGenres({
    super.key,
    required this.movieGenres,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Constants.paddingSize),
      child: Text(
        movieGenres.join(' - '),
        style: const TextStyle(fontSize: Constants.textFont),
      ),
    );
  }
}
