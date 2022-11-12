import 'package:flutter/material.dart';
import 'package:learn_numbers/screens/hundred_screen.dart';
import 'package:learn_numbers/screens/one_screen.dart';
import 'package:learn_numbers/screens/ten_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '123',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(title: 'Turkish'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(widget.title),
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
