import 'package:flutter/material.dart';

import 'like_button.dart';
import '/constants/constants.dart';

class LikeAndRating extends StatelessWidget {
  final double voteAverage;

  const LikeAndRating({
    super.key,
    required this.voteAverage,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Padding(
          padding: EdgeInsets.all(Constants.paddingSize),
          child: LikeButton(),
        ),
        Padding(
          padding: const EdgeInsets.all(Constants.paddingSize),
          child: Text('$voteAverage'),
        ),
      ],
    );
  }
}
