import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../../lib/src/presentation/widget/movie_info_screen/movie_app_bar.dart';

void main() {
  testWidgets('MovieAppBar widget test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          appBar: MovieAppBar(
            movieTitle: 'Movie Title',
          ),
        ),
      ),
    );

    final titleWidget = find.text('Movie Title');

    expect(
      titleWidget,
      findsOneWidget,
    );
  });
}
