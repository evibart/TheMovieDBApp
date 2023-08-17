import 'package:flutter/material.dart';

class MovieAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String movieTitle;

  const MovieAppBar({
    super.key,
    required this.movieTitle,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: kToolbarHeight,
      title: Text(movieTitle),
      leading: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.arrow_back),
      ),
    );
  }
}
