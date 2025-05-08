import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'my_app.dart';
import 'src/data/datasource/local/database_provider.dart';

class SplashScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with SingleTickerProviderStateMixin {
  static const double splashImageSize = 100;
  static const double splashSeparator = 20;
  static const double splashFontSize = 40;
  static const String splashImagePath = 'assets/mario_head.png';
  static const String splashTitle = 'TMDB App';

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    ref.read(databaseProvider.notifier).initializeDatabase();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
    super.dispose();
  }

  void navigateToNextScreen() {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (_) => const MyApp()));
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<DatabaseState>(databaseProvider, (previous, next) {
      if (next == DatabaseState.ready) {
        navigateToNextScreen();
      }
    });
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          colors: [
            Colors.blueAccent,
            Colors.deepPurple,
          ],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              splashImagePath,
              width: splashImageSize,
              height: splashImageSize,
            ),
            SizedBox(height: splashSeparator),
            Text(
              splashTitle,
              style: TextStyle(
                fontStyle: FontStyle.italic,
                color: Colors.white,
                fontSize: splashFontSize,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
