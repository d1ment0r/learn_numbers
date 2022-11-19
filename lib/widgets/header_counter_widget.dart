import 'dart:developer' as developer;

import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:learn_numbers/bloc/bloc.dart';
import 'package:learn_numbers/bloc/state.dart';

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
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 20.0),
              child: Row(
                children: [
                  Text(
                    state.good.toString(),
                    style: const TextStyle(
                        color: Colors.green,
                        // fontWeight: FontWeight.bold,
                        fontSize: 22.0),
                  ),
                  const Text(' / '),
                  Text(
                    state.wrong.toString(),
                    style: const TextStyle(
                        color: Colors.red,
                        // fontWeight: FontWeight.bold,
                        fontSize: 22.0),
                  ),
                  const Text(' / '),
                  Text(
                    state.counter.toString(),
                    style: const TextStyle(
                        // color: Colors.green,
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
                      height: 30.0,
                      width: 30.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.grey.shade100,
                            Colors.grey.shade100,
                          ],
                        ),
                        boxShadow: !state.buttonReverse
                            ? [
                                const BoxShadow(
                                  color: Color(0xffccd0d3),
                                  spreadRadius: 2,
                                  blurRadius: 2,
                                  offset: Offset(3, 3),
                                ),
                                const BoxShadow(
                                  color: Colors.white,
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: Offset(-3, -3),
                                ),
                              ]
                            : [
                                const BoxShadow(
                                  color: Color(0xffffffff),
                                  offset: Offset(-3, -3),
                                  blurRadius: 1,
                                  spreadRadius: 2,
                                  inset: true,
                                ),
                                const BoxShadow(
                                  color: Color(0xffccd0d3),
                                  offset: Offset(3, 3),
                                  blurRadius: 1,
                                  spreadRadius: 2,
                                  inset: true,
                                ),
                              ],
                      ),
                    ),
                    SvgPicture.asset(
                      'assets/images/rotate.svg',
                      width: 22,
                      height: 22,
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
