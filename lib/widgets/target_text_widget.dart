import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as developer;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_numbers/bloc/bloc.dart';
import 'package:learn_numbers/bloc/state.dart';
import 'package:learn_numbers/models/globals.dart' as globals;
import 'package:learn_numbers/themes/theme.dart';

class TargetTextWinget extends StatelessWidget {
  const TargetTextWinget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double resize = 1;
    double height = MediaQuery.of(context).size.height;
    if (height < 600) {
      resize = 0.65;
    }
    bool isDark = ThemeModelInheritedNotifier.of(context).theme.brightness ==
        Brightness.dark;
    return BlocConsumer<AppBlocBloc, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state.buttomPressed && state.buttonChoise == state.truePosition) {
          Future.delayed(const Duration(milliseconds: 200), () {
            developer.log('Target text widget: - updateScreenData');
            context.read<AppBlocBloc>().add(UpdateScreenEvent());
          });
        }
        return SizedBox(
          height: 140 * resize,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Text(
                state.buttonReverse
                    ? state.target.toString()
                    : globals.sortingMap[state.target],
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isDark ? darkAppTextColor : lithAppTextColor,
                  fontSize: state.page == 1
                      ? state.buttonReverse
                          ? 100.0 * resize // число первый экран
                          : 50.0 * resize // слово первый экран
                      : state.page == 2
                          ? state.buttonReverse
                              ? 100.0 * resize // число второй экран
                              : 45.0 * resize // слово второй экран
                          : state.buttonReverse
                              ? 100.0 * resize // число третий экран
                              : 40.0 * resize, // слово третий экран
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
