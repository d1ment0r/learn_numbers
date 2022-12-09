import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:learn_numbers/models/globals.dart' as globals;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:learn_numbers/themes/theme.dart';

import '../bloc/bloc.dart';
import '../bloc/state.dart';

class SwitchSoundWidget extends StatefulWidget {
  const SwitchSoundWidget({super.key});

  @override
  State<SwitchSoundWidget> createState() => _SwitchSoundWidgetState();
}

class _SwitchSoundWidgetState extends State<SwitchSoundWidget> {
  @override
  Widget build(BuildContext context) {
    // Full screen width
    double width = MediaQuery.of(context).size.width;
    double leftPaddingValue = width / 6;
    bool isDark = ThemeModelInheritedNotifier.of(context).theme.brightness ==
        Brightness.dark;
    return Flexible(
      child: BlocConsumer<AppBlocBloc, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Align(
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () {
                if (globals.voice != null) {
                  globals.soundOn = !globals.soundOn;
                  context.read<AppBlocBloc>().add(ChangeSoundStateEvent());
                }
              },
              child: Padding(
                padding: EdgeInsets.only(left: leftPaddingValue),
                child: Container(
                  width: 85.0,
                  height: 40.0,
                  alignment: Alignment.center,
                  transformAlignment: Alignment.center,
                  child: Stack(
                    fit: StackFit.passthrough,
                    children: [
                      Container(
                        width: 85,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              isDark ? darkAppColors : lithAppColors,
                              isDark ? darkAppColors : lithAppColors,
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color:
                                  isDark ? darkAppShadowTop : lithAppShadowTop,
                              offset: const Offset(-12, -12),
                              blurRadius: 15,
                              spreadRadius: 0.0,
                              inset: true,
                            ),
                            BoxShadow(
                              color: isDark
                                  ? darkAppShadowBottom
                                  : lithAppShadowBottom,
                              offset: const Offset(12, 12),
                              blurRadius: 15,
                              spreadRadius: 0.0,
                              inset: true,
                            ),
                          ],
                        ),
                      ),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: EdgeInsets.only(
                            left: globals.soundOn && globals.voice != null
                                ? 51.0
                                : 8.0,
                            top: 6.0),
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(24),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              isDark ? darkAppColors : lithAppColors,
                              isDark ? darkAppColors : lithAppColors,
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color:
                                  isDark ? darkAppShadowTop : lithAppShadowTop,
                              offset: const Offset(-4, -4),
                              blurRadius: 5,
                              spreadRadius: 0.0,
                            ),
                            BoxShadow(
                              color: isDark
                                  ? darkAppShadowBottom
                                  : lithAppShadowBottom,
                              offset: const Offset(4, 4),
                              blurRadius: 5,
                              spreadRadius: 0.0,
                            ),
                          ],
                        ),
                      ),
                      AnimatedContainer(
                        width: 20,
                        height: 20,
                        margin: EdgeInsets.only(
                            left: globals.soundOn && globals.voice != null
                                ? 53.0
                                : 10.0,
                            top: 10.0),
                        duration: const Duration(milliseconds: 200),
                        child: globals.soundOn && globals.voice != null
                            ? SvgPicture.asset(
                                'assets/icon/sound_on.svg',
                                color: !isDark ? darkAppColors : lithAppColors,
                              )
                            : SvgPicture.asset(
                                'assets/icon/sound_off.svg',
                                color: !isDark ? darkAppColors : lithAppColors,
                              ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
