import 'package:flutter/material.dart';
import 'package:learn_numbers/screens/choise_screen.dart';
import 'package:learn_numbers/screens/main_screen.dart';

import 'package:learn_numbers/themes/theme.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const ChoiseLanguageScreen(
        firstInit: true,
      ),
      routes: <String, WidgetBuilder>{
        '/choise': (BuildContext context) => const ChoiseLanguageScreen(
              firstInit: true,
            ),
        '/main': (BuildContext context) => const MainScreen(title: 'Turkish'),
      },
    );
  }
}
