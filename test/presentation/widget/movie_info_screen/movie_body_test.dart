import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../../../lib/src/data/datasource/remote/api_service.dart';
import '../../../../lib/src/domain/entity/movie_entity.dart';
import 'package:network_image_mock/network_image_mock.dart';

class MockMovie extends Mock implements MovieEntity {}

class MockApiService extends Mock implements ApiService {}

void main() {
  late MovieEntity movie;

  setUp(() {
    movie = MockMovie();
  });
  group('MovieBody Widget', () {
    testWidgets('Renders MovieInfo widget', (WidgetTester tester) async {
      when(() => movie.backdrop).thenReturn('');
      await mockNetworkImagesFor(
        () => tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Image(
                      image: NetworkImage(movie.backdrop),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
      expect(
        find.byType(Image),
        findsOneWidget,
      );
    });
  });
}
