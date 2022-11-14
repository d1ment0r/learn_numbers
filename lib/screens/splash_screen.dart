import 'package:flutter/material.dart';
import 'package:learn_numbers/screens/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  initState() {
    super.initState();
    splashDelay();
  }

  void splashDelay() async {
    bool skipChoiseLanguage = false;
    final prefs = await SharedPreferences.getInstance();
    final bool? selectedLanguage = prefs.getBool('selectedLanguage');
    if (selectedLanguage != null) {
      skipChoiseLanguage = selectedLanguage;
    }
    await Future.delayed(
      const Duration(seconds: 3),
    );

    if (!mounted) return;
    if (skipChoiseLanguage) {
      // Navigator.pushNamed(
      //   context,
      //   '/main',
      // );
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => const MainScreen(
                    title: 'Turkish',
                  )),
          (Route route) => false);
    } else {
      Navigator.pushNamed(
        context,
        '/choise',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/splash.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        constraints: const BoxConstraints.expand(),
      ),
    );
  }
}
