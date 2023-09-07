import 'package:flutter/material.dart';

class LikeButton extends StatefulWidget {
  const LikeButton({
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _LikeButton();
}

class _LikeButton extends State<LikeButton> {
  int likes = 0;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        likes++;
        setState(() {});
      },
      icon: const Icon(Icons.favorite),
      label: Text('$likes'),
    );
  }
}
