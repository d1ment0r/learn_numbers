import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_numbers/bloc/bloc.dart';
import 'package:learn_numbers/widgets/button_choise.dart';
import 'package:learn_numbers/widgets/header_counter.dart';
import 'package:learn_numbers/widgets/target_text_widget.dart';
import 'package:number_to_words/number_to_words.dart';

class TenScreen extends StatelessWidget {
  const TenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int target = Random().nextInt(90) + 10;
    int varOne = Random().nextInt(90) + 10;
    while (varOne == target) {
      varOne = Random().nextInt(90) + 10;
    }
    int varTwo = Random().nextInt(90) + 10;
    while (varTwo == target || varTwo == varOne) {
      varTwo = Random().nextInt(90) + 10;
    }
    int truePosition = Random().nextInt(3);
    String strTarget =
        target > 0 ? NumberToWord().convert('en-in', target) : 'zero';
    String strVarOne =
        varOne > 0 ? NumberToWord().convert('en-in', varOne) : 'zero';
    String strVarTwo =
        varTwo > 0 ? NumberToWord().convert('en-in', varTwo) : 'zero';
    List<String> textButton = [
      truePosition == 0 ? strTarget : strVarOne,
      truePosition == 1
          ? strTarget
          : truePosition == 2
              ? strVarTwo
              : strVarOne,
      truePosition == 2 ? strTarget : strVarTwo,
    ];

    return BlocProvider(
      create: (context) => AppBlocBloc(
          page: 2,
          target: target,
          truePosition: truePosition,
          buttomPressed: false,
          textButton: textButton,
          counter: 0,
          wrong: 0,
          good: 0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const <Widget>[
            HeaderCounterWidget(),
            TargetTextWinget(),
            ButtonChoiseWidget(number: 0),
            ButtonChoiseWidget(number: 1),
            ButtonChoiseWidget(number: 2),
          ],
        ),
      ),
    );
  }
}
