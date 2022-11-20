import 'package:flutter/material.dart';
import 'dart:developer' as developer;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_numbers/bloc/bloc.dart';
import 'package:learn_numbers/bloc/state.dart';
import 'package:learn_numbers/models/globals.dart' as globals;

class TargetTextWinget extends StatelessWidget {
  const TargetTextWinget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBlocBloc, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state.buttomPressed && state.buttonChoise == state.truePosition) {
          Future.delayed(const Duration(milliseconds: 800), () {
            developer.log('Target text widget: - updateScreenData');
            context.read<AppBlocBloc>().add(UpdateScreenEvent());
          });
        }
        return SizedBox(
          height: 140,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Text(
                state.buttonReverse
                    ? state.target.toString()
                    : globals.sortingMap[state.target],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: state.page == 1
                      ? state.buttonReverse
                          ? 110.0 // число первый экран
                          : 65.0 // слово первый экран
                      : state.page == 2
                          ? state.buttonReverse
                              ? 120.0 // число второй экран
                              : 55.0 // слово второй экран
                          : state.buttonReverse
                              ? 120.0 // число третий экран
                              : 40.0, // слово третий экран
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
