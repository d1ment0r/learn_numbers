import 'dart:developer' as developer;
import 'package:learn_numbers/models/globals.dart' as globals;
import 'dart:math';

import 'package:learn_numbers/models/globals.dart';
import 'package:learn_numbers/models/translate.dart';
import 'package:number_to_words/number_to_words.dart';

class AppState {
  int counter = 0;
  bool buttomPressed = false;
  bool buttonHelpPressed = false;
  int buttonChoise = 0;
  int wrong = 0;
  int good = 0;
  late int page;
  late int target;
  late int truePosition;
  late List<String> textButton;
  List<int> listButton = [0, 0, 0];

  AppState({
    required this.page,
    required this.counter,
    required this.wrong,
    required this.good,
    required this.target,
    required this.buttomPressed,
    required this.buttonHelpPressed,
    required this.buttonChoise,
    required this.truePosition,
    required this.textButton,
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
    List<String> textButton = ['', '', ''];
    // print('target $target this.target ${this.target}');
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

    // Старая модель заполнения
    textButton = [
      truePosition == 0
          ? getTranslateTarget(target)
          : getTranslateTarget(varOne),
      truePosition == 1
          ? getTranslateTarget(target)
          : truePosition == 2
              ? getTranslateTarget(varTwo)
              : getTranslateTarget(varOne),
      truePosition == 2
          ? getTranslateTarget(target)
          : getTranslateTarget(varTwo),
    ];
    // print('$textButton target $target');
    this.textButton = textButton;
    this.target = target;
    buttonHelpPressed = false;
    // this.truePosition = truePosition;
    developer.log('State - AppState.update target($target)');
  }
}

int getRandomTarget(int page) {
  switch (page) {
    case 1:
      return Random().nextInt(10);
    case 2:
      return Random().nextInt(90) + 10;
    case 3:
      return Random().nextInt(900) + 100;
    default:
      return 0;
  }
}

String getTranslateTarget(int target) {
  return target > 0 ? NumberToWord().convert('en-in', target) : 'zero';
}
