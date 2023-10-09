import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../../lib/src/core/util/constants.dart';
import '../../../../lib/src/presentation/widget/movie_info_screen/like_button.dart';

void main() {
  testWidgets('LikeButton increments likes when pressed',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: LikeButton(),
      ),
    ));

    expect(
      find.text('0'),
      findsOneWidget,
    );

    await tester.tap(find.byKey(Key(Constants.likeButtonKey)));
    await tester.pump();

    expect(
      find.text('1'),
      findsOneWidget,
    );
  });
}
