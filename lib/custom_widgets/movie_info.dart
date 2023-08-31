import 'package:flutter/material.dart';

import '/constants/constants.dart';

class MovieInfo extends StatelessWidget {
  final String poster;
  final String originalTitle;
  final String overview;
  final String releaseDate;
  static const double posterWidth = 200;
  static const double sizedBoxHeight = 8;
  static const double titleFont = 20;
  static const double borderRadius = 30;

  const MovieInfo({
    super.key,
    required this.poster,
    required this.originalTitle,
    required this.overview,
    required this.releaseDate,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: Image.asset(
            poster,
            width: posterWidth,
            fit: BoxFit.cover,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(Constants.paddingSize),
            child: Column(
              children: [
                Text(
                  originalTitle,
                  style: const TextStyle(
                    fontSize: titleFont,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: sizedBoxHeight),
                Text(overview),
                const SizedBox(height: sizedBoxHeight),
                Text(
                  'Release Date: $releaseDate',
                  style: const TextStyle(fontSize: Constants.textFont),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
