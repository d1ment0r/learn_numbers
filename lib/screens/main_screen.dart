import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:learn_numbers/screens/choise_screen.dart';
import 'package:learn_numbers/screens/learning_screen.dart';
import 'dart:developer' as developer;

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
    const LearningScreen(),
    const OneScreen(),
    const TenScreen(),
    const HundredScreen(),
  ];
  final _bottomNavigationBarItems = [
    BottomNavigationBarItem(
        activeIcon: SvgPicture.asset(
          'assets/icon/graduate-student-svgrepo-com.svg',
          width: 28,
          height: 28,
          color: const Color(0xFF3399CC),
        ),
        icon: SvgPicture.asset(
          'assets/icon/graduate-student-svgrepo-com.svg',
          width: 22,
          height: 22,
        ),
        label: ''),
    BottomNavigationBarItem(
        activeIcon: SvgPicture.asset(
          'assets/icon/number-1.svg',
          width: 32,
          height: 32,
          color: const Color(0xFF3399CC),
        ),
        icon: SvgPicture.asset(
          'assets/icon/number-1.svg',
          width: 25,
          height: 25,
        ),
        label: ''),
    BottomNavigationBarItem(
        activeIcon: SvgPicture.asset(
          'assets/icon/number-10.svg',
          width: 32,
          height: 32,
          color: const Color(0xFF3399CC),
        ),
        icon: SvgPicture.asset(
          'assets/icon/number-10.svg',
          width: 25,
          height: 25,
        ),
        label: ''),
    BottomNavigationBarItem(
        activeIcon: SvgPicture.asset(
          'assets/icon/number-100.svg',
          width: 32,
          height: 32,
          color: const Color(0xFF3399CC),
        ),
        icon: SvgPicture.asset(
          'assets/icon/number-100.svg',
          width: 28,
          height: 28,
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
              developer.log('Main screen - push to choise screen');
              Route route = MaterialPageRoute(
                  builder: (context) =>
                      const ChoiseLanguageScreen(firstInit: false));
              Navigator.push(context, route);
            },
          )
        ],
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (value) {
          setState(() {
            _currentPage = value;
          });
        },
        children: pages,
      ),
      bottomNavigationBar: Material(
        // color: Colors.red,
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

          // unselectedLabelStyle: const TextStyle(
          //   fontWeight: FontWeight.w400,
          //   fontSize: 20.0,
          // ),
          // iconSize: 30,
          // selectedLabelStyle: const TextStyle(
          //   fontWeight: FontWeight.bold,
          //   fontSize: 22.0,
          // ),
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
