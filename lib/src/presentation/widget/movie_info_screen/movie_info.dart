import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../core/util/constants.dart';

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
          child: SizedBox(
            width: posterWidth,
            child: CachedNetworkImage(
              imageUrl: poster,
              progressIndicatorBuilder: (
                context,
                url,
                downloadProgress,
              ) =>
                  CircularProgressIndicator(value: downloadProgress.progress),
              errorWidget: (
                context,
                url,
                error,
              ) =>
                  Icon(Icons.error),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(Constants.paddingSize),
            child: Column(
              children: [
                Text(
                  key: Key(Constants.originalTitleKey),
                  originalTitle,
                  style: const TextStyle(
                    fontSize: titleFont,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: sizedBoxHeight),
                Text(
                  key: Key(Constants.overviewKey),
                  overview,
                ),
                const SizedBox(height: sizedBoxHeight),
                Text(
                  'Release Date: $releaseDate',
                  key: Key(Constants.releaseDateKey),
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
