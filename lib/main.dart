import 'package:flare_splash_screen/flare_splash_screen.dart';
import 'package:flutter/material.dart';
import 'screens/tab_screen.dart';
import 'toro_theme.dart';

void main() => runApp(ToroInvestimentosApp());

class ToroInvestimentosApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = 'Toro Investimentos App';

    return MaterialApp(
      title: title,
      theme: toroTheme,
      debugShowCheckedModeBanner: false,
      home: SplashScreen.navigate(
        name: 'assets/splashscreen/loader.flr',
        next: (context) => TabScreen(),
        until: () => Future.delayed(Duration(seconds: 3)),
        startAnimation: 'animation',
      ),
    );
  }
}
