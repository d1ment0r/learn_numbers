library globals;

import 'dart:collection';

import 'package:learn_numbers/models/language.dart';

SplayTreeMap sortingMap = SplayTreeMap<int, String>();
bool reversMap = false;
bool soundOn = true;
bool splashScreenOn = true;
int currentPage = 1;

// Settings speech
double volume = 1; // Range: 0-1
double rate = 1; // Range: 0-2
double pitch = 1; // Range: 0-2

Language? currentLanguage;
