// import 'dart:developer' as developer;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:learn_numbers/models/globals.dart' as globals;
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_numbers/bloc/bloc.dart';
import 'package:learn_numbers/bloc/state.dart';

class ButtonChoiseWidget extends StatefulWidget {
  const ButtonChoiseWidget({
    super.key,
    required this.number,
  });

  final int number;

  @override
  State<ButtonChoiseWidget> createState() => _ButtonChoiseWidgetState();
}

class _ButtonChoiseWidgetState extends State<ButtonChoiseWidget> {
  bool isRedButton = false;
  bool isGreenButton = false;
  bool _isElevated = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBlocBloc, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        isRedButton = state.buttonChoise == widget.number &&
            state.buttonChoise != state.truePosition &&
            state.buttomPressed;
        isGreenButton =
            state.buttonHelpPressed && state.truePosition == widget.number;
        state.buttomPressed && widget.number != state.truePosition;
        _isElevated = state.buttomPressed &&
            state.buttonChoise == widget.number &&
            state.buttonChoise == state.truePosition;
        return Center(
          child: GestureDetector(
            onTap: () {
              context
                  .read<AppBlocBloc>()
                  .add(PressButtonChoiseEvent(widget.number));
            },
            child: AnimatedContainer(
              duration: const Duration(microseconds: 300),
              margin: const EdgeInsets.only(top: 20, left: 40.0, right: 40.0),
              height: 48,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
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
                    : [
                        const BoxShadow(
                          offset: Offset(-3, -3),
                          blurRadius: 8,
                          spreadRadius: 1,
                          color: Colors.white,
                          inset: true,
                        ),
                        BoxShadow(
                          offset: const Offset(3, 3),
                          blurRadius: 8,
                          spreadRadius: 1,
                          color: Colors.grey.shade500,
                          inset: true,
                        )
                      ],
              ),

              /// TEXT
              child: Center(
                child: Text(
                  state.buttonReverse
                      ? globals.sortingMap[state.listButton[widget.number]]
                      : state.listButton[widget.number].toString(),
                  style: TextStyle(
                      color: isGreenButton
                          ? Colors.green
                          : isRedButton
                              ? Colors.red
                              : Colors.black,
                      fontSize: state.page == 1
                          ? !state.buttonReverse
                              ? 30.0
                              : 28.0
                          : state.page == 2
                              ? !state.buttonReverse
                                  ? 30.0
                                  : 25.0
                              : !state.buttonReverse
                                  ? 30.0
                                  : 23.0,
                      fontWeight: state.buttonReverse
                          ? FontWeight.w500
                          : FontWeight.w700),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}