import 'package:flutter/material.dart';
import 'package:learn_numbers/screens/learning_screen.dart';
import 'dart:developer' as console;
import 'package:learn_numbers/models/globals.dart' as globals;
import 'package:learn_numbers/screens/settings_screen.dart';
import 'package:learn_numbers/screens/choise_screen.dart';
import 'package:learn_numbers/widgets/bottom_navigation_items.dart';

class AppScreen extends StatefulWidget {
  const AppScreen({super.key, required this.title});
  final String title;

  @override
  State<AppScreen> createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  int _currentPage = 0;

  final PageController _pageController = PageController(initialPage: 0);

  List<Widget> pages = <Widget>[
    ChoiseScreen(page: 1),
    ChoiseScreen(page: 2),
    ChoiseScreen(page: 3),
    const LearningScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(widget.title),
        // backgroundColor: const Color(0xFF3399CC),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.settings,
              // color: Colors.white,
            ),
            onPressed: () {
              console.log(
                  '\u001b[1;33mMain screen: \u001b[1;34monPressed IconButton\u001b[0m, first init: \u001b[1;32mfalse');
              Route route = MaterialPageRoute(
                  builder: (context) => const SettingsScreen(firstInit: false));
              Navigator.push(context, route);
            },
          )
        ],
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (value) {
          globals.currentPage = value + 1;
          console.log(
              '\u001b[1;33mApp screen: \u001b[1;34mPageView \u001b[0mchange page to: \u001b[1;32m${globals.currentPage} \u001b[0mvalue: \u001b[1;32m$value');
          setState(
            () {
              _currentPage = value;
            },
          );
        },
        children: pages,
      ),
      bottomNavigationBar: _bottomNavigationBar(),
    );
    // );
  }

  BottomNavigationBar _bottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _currentPage ?? 0,
      items: bottomNavigationBarItems,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedLabelStyle: const TextStyle(fontSize: 0),
      unselectedLabelStyle: const TextStyle(fontSize: 0),
      onTap: ((value) {
        _pageController.animateToPage(value,
            duration: const Duration(milliseconds: 400), curve: Curves.ease);
        globals.currentPage = value + 1;
        console.log(
            '\u001b[1;33mApp screen: \u001b[1;34monTap Bottom navigator \u001b[0mchange page to: \u001b[1;32m${globals.currentPage}');
        setState(() {
          _currentPage = value;
        });
      }),
    );
  }
}
