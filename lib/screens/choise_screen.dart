import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_numbers/bloc/bloc.dart';
import 'package:learn_numbers/widgets/bottom_buttons_widget.dart';
import 'package:learn_numbers/widgets/button_choise_widget.dart';
import 'package:learn_numbers/widgets/header_counter_widget.dart';
import 'package:learn_numbers/widgets/target_text_widget.dart';
import 'dart:developer' as console;

// ignore: must_be_immutable
class ChoiseScreen extends StatefulWidget {
  int page;
  ChoiseScreen({required this.page, super.key});

  @override
  State<ChoiseScreen> createState() => _ChoiseScreenState();
}

class _ChoiseScreenState extends State<ChoiseScreen> {
  @override
  void initState() {
    super.initState();
    console.log(
        '\u001b[1;33mChoise screen: \u001b[1;34mInit State \u001b[0m, page: \u001b[1;32m${widget.page}');
  }

  @override
  Widget build(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
    return BlocProvider(
      create: (context) => AppBlocBloc(page: widget.page),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const <Widget>[
            HeaderCounterWidget(),
            TargetTextWinget(),
            ButtonChoiseWidget(number: 0),
            ButtonChoiseWidget(number: 1),
            ButtonChoiseWidget(number: 2),
            BottomButtonWidget(),
          ],
        ),
      ),
    );
  }
}
