import 'package:flutter/material.dart';
import 'package:learn_numbers/screens/choise_language_screen.dart';
import 'package:learn_numbers/screens/splash_screen.dart';
import 'package:learn_numbers/themes/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      // home: const SplashScreen(),
      home: const ChoiseLanguageScreen(),
      routes: <String, WidgetBuilder>{
        '/splash': (BuildContext context) => const SplashScreen(),
        '/choise': (BuildContext context) => const ChoiseLanguageScreen(),
        // '/main': (BuildContext context) => const MainScreen(title: 'Turkish'),
      },
    );
  }
}
