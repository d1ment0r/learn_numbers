import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:learn_numbers/core/theme_service.dart';
import 'package:learn_numbers/screens/settings_screen.dart';
import 'package:learn_numbers/screens/app_screen.dart';

import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  // theme
  WidgetsFlutterBinding.ensureInitialized();
  final themeService = await ThemeService.instance;
  var initTheme = themeService.initial;
  // splash screen
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(MyApp(theme: initTheme));
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.theme,
  }) : super(key: key);
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      initTheme: theme,
      builder: (_, theme) {
        return MaterialApp(
          theme: theme,
          debugShowCheckedModeBanner: false,
          home: const SettingsScreen(
            firstInit: true,
          ),
          routes: <String, WidgetBuilder>{
            '/setting': (BuildContext context) => const SettingsScreen(
                  firstInit: true,
                ),
            '/main': (BuildContext context) => const AppScreen(title: ''),
          },
        );
      },
    );
  }
}
