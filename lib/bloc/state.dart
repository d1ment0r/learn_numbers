import 'dart:developer' as console;
import 'dart:math';
import 'package:learn_numbers/core/speech.dart';
import 'package:learn_numbers/models/choise.dart';
import 'package:learn_numbers/models/globals.dart' as globals;
import 'package:number_to_words/number_to_words.dart';
import 'package:text_to_speech/text_to_speech.dart';

TextToSpeech tts = TextToSpeech();

class AppState {
  bool buttomPressed = false;
  bool buttonHelpPressed = false;
  bool buttonReverse = globals.reversMap;
  bool soundOn = globals.soundOn;
  int buttonChoise = 0;
  late int page;
  int target = 0;
  int truePosition = 0;
  List<int> listButton = [0, 0, 0];

  AppState({
    required this.page,
    required this.target,
    required this.buttomPressed,
    required this.buttonReverse,
    required this.buttonHelpPressed,
    required this.soundOn,
    required this.buttonChoise,
    required this.truePosition,
    required this.listButton,
  }) {
    console.log('State - AppState');
  }

  AppState.init({
    required this.page,
  }) {
    if (globals.stateChoise[page - 1] == null) {
      buttonReverse = globals.reversMap;
      target = getRandomTarget(page);
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

      buttonHelpPressed = false;

      globals.stateChoise[page - 1] = Choise(
          listButton: listButton,
          page: page,
          target: target,
          truePosition: truePosition);
    } else {
      target = globals.stateChoise[page - 1]!.target;

      truePosition = globals.stateChoise[page - 1]!.truePosition;
      listButton = globals.stateChoise[page - 1]!.listButton;
    }
    if (globals.soundOn) {
      Future.delayed(const Duration(milliseconds: 400), () {
        speech(target.toString(), page);
      });
    }
    console.log(
        '\u001b[1;33mState: \u001b[1;34mAppState.init\u001b[0m, page: \u001b[1;32m$page');
  }

  AppState.speech({
    required this.page,
    required this.target,
    required this.buttomPressed,
    required this.buttonReverse,
    required this.buttonHelpPressed,
    required this.soundOn,
    required this.buttonChoise,
    required this.truePosition,
    required this.listButton,
  }) {
    console.log('\u001b[1;33mState: \u001b[1;34mAppState.speech');
    if (soundOn) {
      // Future.delayed(const Duration(milliseconds: 200), () {
      // speech(globals.sortingMap[target], page);
      speech(target.toString(), page);
      // });
    }
  }

  AppState.update({
    required this.page,
    required this.target,
    required this.buttomPressed,
    required this.buttonHelpPressed,
    required this.truePosition,
  }) {
    // Обновляем эту же страницу после нажатия кнопки
    int target = this.target;
    buttonReverse = globals.reversMap;
    target = getRandomTarget(page);
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
    if (globals.soundOn) {
      Future.delayed(const Duration(milliseconds: 400), () {
        speech(target.toString(), page);
      });
    }
    globals.stateChoise[page - 1] = Choise(
        listButton: listButton,
        page: page,
        target: target,
        truePosition: truePosition);
    console.log(
        '\u001b[1;33mState:\u001b[1;34m AppState.update \u001b[0mpage: \u001b[1;32m$page');
  }
}

// Random().nextInt(100) + 50; // Value is >= 50 and < 150.
int getRandomTarget(int page) {
  switch (page) {
    case 1:
      return Random().nextInt(10); // >= 0 and < 10
    case 2:
      return Random().nextInt(90) + 10; // >= 10 and < 100
    case 3:
      return Random().nextInt(900) + 100; // >= 100 and < 1000
    default:
      return 0;
  }
}

String getTranslateTarget(int target) {
  return target > 0 ? NumberToWord().convert('en-in', target) : 'zero';
}
