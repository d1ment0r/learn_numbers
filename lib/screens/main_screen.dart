import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:flutter_svg/svg.dart';
import 'package:learn_numbers/screens/learning_screen.dart';
import 'dart:developer' as console;
import 'package:learn_numbers/models/globals.dart' as globals;
import 'package:learn_numbers/screens/settings_screen.dart';

import 'one_screen.dart';
import 'two_screen.dart';
import 'three_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, required this.title});
  final String title;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
  }

  int _currentPage = 0;

  final PageController _pageController = PageController(initialPage: 0);

  final pages = [
    const OneScreen(),
    const TenScreen(),
    const HundredScreen(),
    const LearningScreen(),
  ];
  final _bottomNavigationBarItems = [
    BottomNavigationBarItem(
        activeIcon: SvgPicture.asset(
          'assets/icon/number-1.svg',
          width: 32,
          height: 32,
          // color: const Color(0xFF3399CC),
          color: Colors.black,
        ),
        icon: SvgPicture.asset(
          'assets/icon/number-1.svg',
          width: 32,
          height: 32,
          color: Colors.grey.shade500,
        ),
        label: ''),
    BottomNavigationBarItem(
        activeIcon: SvgPicture.asset(
          'assets/icon/number-10.svg',
          width: 32,
          height: 32,

          // color: const Color(0xFF3399CC),
          color: Colors.black,
        ),
        icon: SvgPicture.asset(
          'assets/icon/number-10.svg',
          width: 32,
          height: 32,
          color: Colors.grey.shade500,
        ),
        label: ''),
    BottomNavigationBarItem(
        activeIcon: SvgPicture.asset(
          'assets/icon/number-100.svg',
          width: 32,
          height: 32,
          // color: const Color(0xFF3399CC),
          color: Colors.black,
        ),
        icon: SvgPicture.asset(
          'assets/icon/number-100.svg',
          width: 32,
          height: 32,
          color: Colors.grey.shade500,
        ),
        label: ''),
    BottomNavigationBarItem(
        activeIcon: const Icon(
          Icons.list_alt,
          size: 28,
          // color: Color(0xFF3399CC),
          color: Colors.black,
        ),
        icon: Icon(
          Icons.list_alt,
          size: 28,
          color: Colors.grey.shade500,
        ),
        label: ''),
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: const Color(0xFF3399CC),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
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
          setState(() {
            _currentPage = value;
            console.log(
                '\u001b[1;33mMain screen: \u001b[1;34mPageView \u001b[0mchange page to: \u001b[1;32m$value');
          });
        },
        children: pages,
      ),
      bottomNavigationBar: Material(
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentPage,
          items: _bottomNavigationBarItems,
          backgroundColor: colorScheme.surface,
          selectedItemColor: colorScheme.onSurface,
          // selectedItemColor: Colors.amber,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedLabelStyle: const TextStyle(fontSize: 0),
          unselectedLabelStyle: const TextStyle(fontSize: 0),

          onTap: ((value) {
            _pageController.animateToPage(value,
                duration: const Duration(milliseconds: 400),
                curve: Curves.ease);
          }),
        ),
      ),
    );
  }
}
