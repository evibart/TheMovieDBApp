import 'package:flutter/material.dart';

import '../../../core/util/movie_enum.dart';

class MovieListAppBar extends StatelessWidget implements PreferredSizeWidget {
  final MovieEndpoint pageTitle;

  const MovieListAppBar({
    required this.pageTitle,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: kToolbarHeight,
      title: Text(pageTitle.title),
    );
  }
}
