library globals;

import 'dart:collection';

import 'package:learn_numbers/models/choise.dart';
import 'package:learn_numbers/models/language.dart';

SplayTreeMap sortingMap = SplayTreeMap<int, String>();
bool reversMap = false;
bool soundOn = true;
bool splashScreenOn = true;
int currentPage = 1;

// Set counter
int counter = 0;
int wrong = 0;
int good = 0;

// Settings Speech
double volume = 1; // Range: 0-1
double rate = 1; // Range: 0-2
double pitch = 1; // Range: 0-2
String? voice;

Language currentLanguage = Language.getDefault();

//Counter Answers
int totalAnswers = 0;
int totalTrueAnswers = 0;
int totalFalseAnswers = 0;

// Set State
List<Choise?> stateChoise = [null, null, null];

// Colors message in console debug
// Text
// console.log( "\u001b[1;31m Red message" );
// console.log( "\u001b[1;32m Green message" );
// console.log( "\u001b[1;33m Yellow message" );
// console.log( "\u001b[1;34m Blue message" );
// console.log( "\u001b[1;35m Purple message" );
// console.log( "\u001b[1;36m Cyan message" );
// Background
// console.log( "\u001b[1;41m Red background" );
// console.log( "\u001b[1;42m Green background" );
// console.log( "\u001b[1;43m Yellow background" );
// console.log( "\u001b[1;44m Blue background" );
// console.log( "\u001b[1;45m Purple background" );
// console.log( "\u001b[1;46m Cyan background" );
// Reset
// console.log( "\u001b[0m Reset text and background color/style to default" );
// Example
// console.log( "\u001b[1;31m --process: Error" + "\u001b[0m" );

// Мой шаблон
// '\u001b[1;36m Settings screen: \u001b[0m initSate - \u001b[1;32m firstInit');