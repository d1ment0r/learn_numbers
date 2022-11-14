import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_numbers/bloc/bloc.dart';
import 'package:learn_numbers/widgets/bottom_buttons_widget.dart';
import 'package:learn_numbers/widgets/button_choise.dart';
import 'package:learn_numbers/widgets/header_counter.dart';
import 'package:learn_numbers/widgets/target_text_widget.dart';

class TenScreen extends StatelessWidget {
  const TenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppBlocBloc(page: 2),
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
