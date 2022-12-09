import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

final bottomNavigationBarItems = [
  BottomNavigationBarItem(
      // activeIcon: SvgPicture.asset(
      //   'assets/icon/number-1.svg',
      //   width: 32,
      //   height: 32,
      //   // color: const Color(0xFF3399CC),
      //   // color: Colors.black,
      // ),
      icon: SvgPicture.asset(
        'assets/icon/number-1.svg',
        width: 32,
        height: 32,
        // color: Colors.grey.shade500,
      ),
      label: ''),
  BottomNavigationBarItem(
      // activeIcon: SvgPicture.asset(
      //   'assets/icon/number-10.svg',
      //   width: 32,
      //   height: 32,
      //   // color: const Color(0xFF3399CC),
      //   // color: Colors.black,
      // ),
      icon: SvgPicture.asset(
        'assets/icon/number-10.svg',
        width: 32,
        height: 32,
        // color: Colors.grey.shade500,
      ),
      label: ''),
  BottomNavigationBarItem(
      // activeIcon: SvgPicture.asset(
      //   'assets/icon/number-100.svg',
      //   width: 32,
      //   height: 32,
      //   // color: const Color(0xFF3399CC),
      //   // color: Colors.black,
      // ),
      icon: SvgPicture.asset(
        'assets/icon/number-100.svg',
        width: 32,
        height: 32,
        // color: Colors.grey.shade500,
      ),
      label: ''),
  const BottomNavigationBarItem(
      activeIcon: Icon(
        Icons.list_alt,
        size: 28,
        // color: Color(0xFF3399CC),
        // color: Colors.black,
      ),
      icon: Icon(
        Icons.list_alt,
        size: 28,

        // color: Colors.grey.shade500,
      ),
      label: ''),
];
