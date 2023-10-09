import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../../../lib/src/core/util/constants.dart';
import '../../../../lib/src/domain/entity/movie_entity.dart';
import '../../../../lib/src/presentation/widget/movie_info_screen/movie_info.dart';
import 'package:network_image_mock/network_image_mock.dart';

class MockMovie extends Mock implements MovieEntity {}

void main() {
  late MovieEntity movie;
  setUp(() {
    movie = MockMovie();
  });

  group('MovieInfo Widget', () {
    testWidgets('Renders MovieInfo widget', (WidgetTester tester) async {
      when(() => movie.originalTitle).thenReturn('Title');
      when(() => movie.releaseDate).thenReturn(DateTime(2023, 8, 9));
      when(() => movie.poster).thenReturn('');
      when(() => movie.overview).thenReturn('Description');
      await mockNetworkImagesFor(() => tester.pumpWidget(MaterialApp(
              home: Scaffold(
                  body: MovieInfo(
            poster: '',
            originalTitle: '',
            overview: '',
            releaseDate: '',
          )))));

      expect(
        find.byKey(Key(Constants.originalTitleKey)),
        findsOneWidget,
      );
      expect(
        find.byKey(Key(Constants.overviewKey)),
        findsOneWidget,
      );
      expect(
        find.byKey(Key(Constants.releaseDateKey)),
        findsOneWidget,
      );
      expect(
        find.byType(Image),
        findsOneWidget,
      );
    });
  });
}
