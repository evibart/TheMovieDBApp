import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../../lib/src/presentation/widget/movie_info_screen/like_button.dart';
import '../../../../lib/src/presentation/widget/movie_info_screen/likes_rating.dart';

void main() {
  testWidgets('LikeAndRating widget test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: LikeAndRating(
          voteAverage: 7.8,
        ),
      ),
    );

    final likeButton = find.byType(LikeButton);
    final textWidget = find.text('7.8');

    expect(
      likeButton,
      findsOneWidget,
    );
    expect(
      textWidget,
      findsOneWidget,
    );
  });
}
