import 'dart:developer' as developer;
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
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
                child: AnimatedContainer(
                  duration: const Duration(microseconds: 250),
                  height: 30.0,
                  width: 30.0,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(25),
                    image: const DecorationImage(
                      image: Svg('assets/images/rotate.svg',
                          size: Size(24.0, 24.0), color: Colors.black),
                    ),
                    boxShadow: !_isElevated
                        ? [
                            BoxShadow(
                              color: Colors.grey.shade500,
                              spreadRadius: 1,
                              blurRadius: 8,
                              offset: const Offset(4, 4),
                            ),
                            const BoxShadow(
                              color: Colors.white,
                              spreadRadius: 2,
                              blurRadius: 8,
                              offset: Offset(-4, -4),
                            ),
                          ]
                        : null,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
