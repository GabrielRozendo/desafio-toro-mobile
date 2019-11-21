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
      home: TabScreen(),
    );
  }
}
