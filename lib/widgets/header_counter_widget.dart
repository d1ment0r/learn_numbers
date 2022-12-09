import 'dart:developer' as developer;
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:learn_numbers/models/globals.dart' as globals;

import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:learn_numbers/bloc/bloc.dart';
import 'package:learn_numbers/bloc/state.dart';
import 'package:learn_numbers/themes/theme.dart';

class HeaderCounterWidget extends StatefulWidget {
  const HeaderCounterWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<HeaderCounterWidget> createState() => _HeaderCounterWidgetState();
}

class _HeaderCounterWidgetState extends State<HeaderCounterWidget> {
  bool _isElevated = false;

  @override
  Widget build(BuildContext context) {
    if (_isElevated) {
      Future.delayed(const Duration(milliseconds: 150), () {
        developer.log('press reverse button');
        context.read<AppBlocBloc>().add(PressButtonReversEvent());
        _isElevated = false;
      });
      //
    }

    return BlocConsumer<AppBlocBloc, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        bool isDark =
            ThemeModelInheritedNotifier.of(context).theme.brightness ==
                Brightness.dark;
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 20.0),
              child: Row(
                children: [
                  Text(
                    globals.good.toString(),
                    style: const TextStyle(
                        color: Colors.green,
                        // fontWeight: FontWeight.bold,
                        fontSize: 22.0),
                  ),
                  const Text(' / '),
                  Text(
                    globals.wrong.toString(),
                    style: const TextStyle(
                        color: Colors.red,
                        // fontWeight: FontWeight.bold,
                        fontSize: 22.0),
                  ),
                  const Text(' / '),
                  Text(
                    globals.counter.toString(),
                    style: TextStyle(
                        color: isDark ? darkAppTextColor : lithAppTextColor,
                        // fontWeight: FontWeight.bold,
                        fontSize: 22.0),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, right: 20.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _isElevated = true;
                  });
                },
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(microseconds: 200),
                      height: 40.0,
                      width: 40.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            isDark ? darkAppColors : lithAppColors,
                            isDark ? darkAppColors : lithAppColors,
                          ],
                        ),
                        boxShadow: !state.buttonReverse
                            ? [
                                BoxShadow(
                                  color: isDark
                                      ? darkAppShadowBottom
                                      : lithAppShadowBottom,
                                  spreadRadius: 2,
                                  blurRadius: 2,
                                  offset: const Offset(3, 3),
                                ),
                                BoxShadow(
                                  color: isDark
                                      ? darkAppShadowTop
                                      : lithAppShadowTop,
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: const Offset(-3, -3),
                                ),
                              ]
                            : [
                                BoxShadow(
                                  color: isDark
                                      ? darkAppShadowTop
                                      : lithAppShadowTop,
                                  offset: const Offset(-4, -4),
                                  blurRadius: 4,
                                  spreadRadius: 2,
                                  inset: true,
                                ),
                                BoxShadow(
                                  color: isDark
                                      ? darkAppShadowBottom
                                      : lithAppShadowBottom,
                                  offset: const Offset(1, 1),
                                  blurRadius: 2,
                                  spreadRadius: 3,
                                  inset: true,
                                ),
                              ],
                      ),
                    ),
                    SvgPicture.asset(
                      'assets/icon/rotate.svg',
                      width: 22,
                      height: 22,
                      color: isDark ? darkAppTextColor : lithAppTextColor,
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
