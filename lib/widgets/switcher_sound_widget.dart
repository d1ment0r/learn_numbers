import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as developer;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../bloc/bloc.dart';
import '../bloc/state.dart';

class SwitchSoundWidget extends StatefulWidget {
  const SwitchSoundWidget({super.key});

  @override
  State<SwitchSoundWidget> createState() => _SwitchSoundWidgetState();
}

bool soundOn = true;

class _SwitchSoundWidgetState extends State<SwitchSoundWidget> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: BlocConsumer<AppBlocBloc, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 5.0, right: 20.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    soundOn = !soundOn;
                    developer.log('Sound : $soundOn');
                  });
                },
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
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xffecf0f3),
                              Color(0xffecf0f3),
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
                            left: soundOn ? 51.0 : 8.0, top: 6.0),
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: const Color(0xffecf0f3),
                          borderRadius: BorderRadius.circular(24),
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xffecf0f3),
                              Color(0xffecf0f3),
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
                            left: soundOn ? 53.0 : 10.0, top: 10.0),
                        duration: const Duration(milliseconds: 200),
                        child: soundOn
                            ? SvgPicture.asset(
                                'assets/images/sound_on.svg',
                                color: Colors.black,
                              )
                            : SvgPicture.asset(
                                'assets/images/sound_off.svg',
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
