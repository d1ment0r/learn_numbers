import 'dart:developer' as console;
import 'dart:math';
import 'package:learn_numbers/models/globals.dart' as globals;
import 'package:learn_numbers/models/language.dart';

import 'package:number_to_words/number_to_words.dart';
import 'package:text_to_speech/text_to_speech.dart';

TextToSpeech tts = TextToSpeech();

class AppState {
  int counter = 0;
  bool buttomPressed = false;
  bool buttonHelpPressed = false;
  bool buttonReverse = globals.reversMap;
  bool soundOn = globals.soundOn;
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
    required this.soundOn,
    required this.buttonChoise,
    required this.truePosition,
    required this.listButton,
  }) {
    console.log('State - AppState');
  }

  AppState.speech({
    required this.page,
    required this.counter,
    required this.wrong,
    required this.good,
    required this.target,
    required this.buttomPressed,
    required this.buttonReverse,
    required this.buttonHelpPressed,
    required this.soundOn,
    required this.buttonChoise,
    required this.truePosition,
    required this.listButton,
  }) {
    console.log(
        'State - AppState.speech page: $page currentPage: ${globals.currentPage}');
    if (soundOn) {
      Future.delayed(const Duration(milliseconds: 200), () {
        speak(globals.sortingMap[target], page);
      });
    }
  }

  AppState.update({
    required this.page,
    required this.counter,
    required this.wrong,
    required this.good,
    required this.target,
    required this.buttomPressed,
    required this.buttonHelpPressed,
    required this.buttonReverse,
    required this.truePosition,
  }) {
    int target = this.target;
    buttonReverse = globals.reversMap;
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
    if (globals.soundOn) {
      Future.delayed(const Duration(seconds: 1), () {
        speak(globals.sortingMap[target], page);
      });
    }
    console.log(
        '\u001b[1;33mState:\u001b[1;34m AppState.update \u001b[0mtarget: \u001b[1;32m$target');
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

Future<void> speak(sayText, page) async {
  if (globals.voice == null || globals.voice == '') {
    console.log(
        '\u001b[1;33mState:\u001b[1;34m speak \u001b[0mvoice is \u001b[1;31mnull');
    return;
  }

  // String voice = '';
  // List<String> translateCodes = <String>[];
  Language? language = globals.currentLanguage;

  // populate lang code (i.e. en-US)
  // translateCodes = await tts.getLanguages();

  // populate displayed language (i.e. English)
  // final List<String>? displayLanguages = await tts.getDisplayLanguages();
  // if (displayLanguages == null) {
  //   return;
  // }

  // languages.clear();
  // for (final dynamic lang in displayLanguages) {
  //   languages.add(lang as String);
  // }

  // final String? defaultLangCode = await tts.getDefaultLanguage();

  // if (language!.voiceCode != '' &&
  //     translateCodes.contains(language.voiceCode)) {
  //   voice = language.voiceCode;
  // } else {
  //   voice = defaultLangCode.toString();
  // }

  // final String? displayLanguage = await tts.getDisplayLanguageByCode(voice);

  tts.setVolume(language!.volume);
  tts.setRate(language.rate);
  // if (voice != '') {
  tts.setLanguage(globals.voice!);
  console.log(
      '\u001b[1;33mState: \u001b[1;34mspeak \u001b[0mvoice set: \u001b[1;32m${globals.voice}');
  // } else {
  //   tts.setLanguage(defaultLangCode!);
  //   console.log('State: voice set: $defaultLangCode');
  // }
  tts.setPitch(globals.pitch);
  // await Future.delayed(const Duration(milliseconds: 500));
  if (page == globals.currentPage) {
    tts.speak(sayText);
  }
  console.log(
      '\u001b[1;33mState: \u001b[1;34mspeak page: \u001b[1;32m$page \u001b[0mcurrentPage: \u001b[1;32m${globals.currentPage}');
}
