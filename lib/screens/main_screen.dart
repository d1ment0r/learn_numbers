import 'package:flutter/material.dart';

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
  ];
  final _bottomNavigationBarItems = [
    const BottomNavigationBarItem(icon: Icon(Icons.abc), label: '1'),
    const BottomNavigationBarItem(icon: Icon(Icons.abc), label: '10'),
    const BottomNavigationBarItem(icon: Icon(Icons.abc), label: '100'),
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(widget.title),
        // backgroundColor: const Color(0xFF3399CC),
        backgroundColor: const Color(0xFF3399CC),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () {
              //
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPage,
        items: _bottomNavigationBarItems,
        backgroundColor: colorScheme.surface,
        selectedItemColor: colorScheme.onSurface,
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 20.0,
        ),
        iconSize: 0,
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 22.0,
        ),
        onTap: ((value) {
          _pageController.animateToPage(value,
              duration: const Duration(milliseconds: 400), curve: Curves.ease);
        }),
      ),
    );
  }
}
