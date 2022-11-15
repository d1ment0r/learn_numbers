import 'dart:developer' as developer;
import 'dart:math';
import 'package:learn_numbers/models/globals.dart' as globals;

import 'package:number_to_words/number_to_words.dart';

class AppState {
  int counter = 0;
  bool buttomPressed = false;
  bool buttonHelpPressed = false;
  bool buttonReverse = false;
  int buttonChoise = 0;
  int wrong = 0;
  int good = 0;
  late int page;
  late int target;
  late int truePosition;
  List<int> listButton = [0, 0, 0];

  AppState({
    required this.page,
    required this.counter,
    required this.wrong,
    required this.good,
    required this.target,
    required this.buttomPressed,
    required this.buttonReverse,
    required this.buttonHelpPressed,
    required this.buttonChoise,
    required this.truePosition,
    required this.listButton,
  }) {
    developer.log('State - AppState');
  }

  AppState.update({
    required this.page,
    required this.counter,
    required this.wrong,
    required this.good,
    required this.target,
    required this.buttomPressed,
    required this.buttonHelpPressed,
    required this.truePosition,
  }) {
    // pause();
    int target = this.target;
    target = getRandomTarget(page);
    // print('target $target this.target ${this.target}');
    while (target == this.target) {
      target = getRandomTarget(page);
    }
    int varOne = getRandomTarget(page);
    while (varOne == target) {
      varOne = getRandomTarget(page);
    }
    int varTwo = getRandomTarget(page);
    while (varTwo == target || varTwo == varOne) {
      varTwo = getRandomTarget(page);
    }
    truePosition = Random().nextInt(3);
    // Заполняем кнопки объектами - переходная модель
    switch (truePosition) {
      case 0:
        {
          listButton[0] = target;
          listButton[1] = varOne;
          listButton[2] = varTwo;
          break;
        }
      case 1:
        {
          listButton[0] = varOne;
          listButton[1] = target;
          listButton[2] = varTwo;
          break;
        }
      case 2:
        {
          listButton[0] = varOne;
          listButton[1] = varTwo;
          listButton[2] = target;
          break;
        }
    }

    this.target = target;
    buttonHelpPressed = false;
    // this.truePosition = truePosition;
    developer.log(
        'State - AppState.update target($target) dowload: ${globals.allNumericAccess}');
  }
}

// Random().nextInt(100) + 50; // Value is >= 50 and < 150.
int getRandomTarget(int page) {
  switch (page) {
    case 1:
      return Random().nextInt(10); // >= 0 and < 10
    case 2:
      if (globals.allNumericAccess) {
        return Random().nextInt(90) + 10; // >= 10 and < 100
      } else {
        return Random().nextInt(20) + 10; // >= 10 and < 30
      }
    case 3:
      if (globals.allNumericAccess) {
        return Random().nextInt(900) + 100; // >= 100 and < 1000
      } else {
        return Random().nextInt(20) + 100; // >= 100 and < 120
      }
    default:
      return 0;
  }
}

String getTranslateTarget(int target) {
  return target > 0 ? NumberToWord().convert('en-in', target) : 'zero';
}
