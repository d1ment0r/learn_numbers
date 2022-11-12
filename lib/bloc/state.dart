import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:number_to_words/number_to_words.dart';

class AppState {
  late int counter;
  late bool buttomPressed = false;
  late int wrong;
  late int good;
  late int page;
  late int target;
  late int truePosition;
  late List<String> textButton;

  AppState({
    required this.counter,
    required this.buttomPressed,
    required this.wrong,
    required this.good,
    required this.target,
    required this.page,
    required this.truePosition,
    required this.textButton,
  });

  AppState.empty(
      {required this.page,
      required this.target,
      required this.truePosition,
      required this.textButton})
      : counter = 0,
        wrong = 0,
        good = 0;

  AppState.update(
      {required this.counter,
      required this.wrong,
      required this.buttomPressed,
      required this.good,
      required this.target,
      required this.page,
      required this.truePosition,
      required this.textButton}) {
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
    print('$textButton target $target');
    this.textButton = textButton;
    this.target = target;
    // this.truePosition = truePosition;
  }

  AppState.asincPause(
      {required this.counter,
      required this.wrong,
      required this.buttomPressed,
      required this.good,
      required this.target,
      required this.page,
      required this.truePosition,
      required this.textButton}) {
    AppState(
        buttomPressed: buttomPressed,
        counter: counter,
        good: good,
        page: page,
        target: target,
        textButton: textButton,
        truePosition: truePosition,
        wrong: wrong);
    _asincPause(
      counter: counter,
      buttomPressed: false,
      good: good,
      page: page,
      target: target,
      textButton: textButton,
      truePosition: truePosition,
      wrong: wrong,
    );
  }

  Future<void> _asincPause(
      {required counter,
      required wrong,
      required buttomPressed,
      required good,
      required target,
      required page,
      required truePosition,
      required textButton}) async {
    await Future.delayed(Duration(seconds: 1));
    AppState.update(
        counter: counter,
        wrong: wrong,
        buttomPressed: true,
        good: good,
        target: target,
        page: page,
        truePosition: truePosition,
        textButton: textButton);
  }

  @override
  List<Object> get props =>
      [page, target, truePosition, textButton, buttomPressed];
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
