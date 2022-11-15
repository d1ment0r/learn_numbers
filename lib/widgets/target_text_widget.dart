import 'package:flutter/material.dart';
import 'dart:developer' as developer;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_numbers/bloc/bloc.dart';
import 'package:learn_numbers/bloc/state.dart';
import 'package:learn_numbers/models/globals.dart' as globals;

class TargetTextWinget extends StatelessWidget {
  const TargetTextWinget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBlocBloc, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state.buttomPressed && state.buttonChoise == state.truePosition) {
          Future.delayed(const Duration(milliseconds: 1100), () {
            developer.log('Function - updateScreenData');
            context.read<AppBlocBloc>().add(UpdateScreenEvent());
          });
        }
        return Container(
          margin: const EdgeInsets.all(0),
          child: Text(
            state.buttonReverse
                ? state.target.toString()
                : globals.sortingMap[state.target],
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: state.page == 1
                    ? state.buttonReverse
                        ? 160.0
                        : 100.0
                    : state.page == 2
                        ? state.buttonReverse
                            ? 155
                            : 75.0
                        : state.buttonReverse
                            ? 160.0
                            : 55.0),
          ),
        );
      },
    );
  }
}
