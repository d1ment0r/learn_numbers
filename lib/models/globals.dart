library globals;

import 'dart:collection';

SplayTreeMap sortingMap = SplayTreeMap<int, String>();
bool reversMap = false;
bool soundOn = true;
bool splashScreenOn = true;

// Settings language speech
String? languageCode = 'tr-TR';
String? language;
String defaultLanguageCode = 'en-US';

// Settings speech
double volume = 1; // Range: 0-1
double rate = 0.8; // Range: 0-2
double pitch = 1.2; // Range: 0-2

