import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:learn_numbers/models/globals.dart' as globals;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

    return Flexible(
      child: BlocConsumer<AppBlocBloc, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Align(
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () {
                globals.soundOn = !globals.soundOn;
                context.read<AppBlocBloc>().add(ChangeSoundStateEvent());
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
                              Colors.grey.shade100,
                              Colors.grey.shade100,
                            ],
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0xffffffff),
                              offset: Offset(-12, -12),
                              blurRadius: 15,
                              spreadRadius: 0.0,
                              inset: true,
                            ),
                            BoxShadow(
                              color: Color(0xffccd0d3),
                              offset: Offset(12, 12),
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
                            left: globals.soundOn ? 51.0 : 8.0, top: 6.0),
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(24),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.grey.shade100,
                              Colors.grey.shade100,
                            ],
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0xffffffff),
                              offset: Offset(-4, -4),
                              blurRadius: 5,
                              spreadRadius: 0.0,
                            ),
                            BoxShadow(
                              color: Color(0xffccd0d3),
                              offset: Offset(4, 4),
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
                            left: globals.soundOn ? 53.0 : 10.0, top: 10.0),
                        duration: const Duration(milliseconds: 200),
                        child: globals.soundOn
                            ? SvgPicture.asset(
                                'assets/icon/sound_on.svg',
                                color: Colors.black,
                              )
                            : SvgPicture.asset(
                                'assets/icon/sound_off.svg',
                                color: Colors.black,
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
