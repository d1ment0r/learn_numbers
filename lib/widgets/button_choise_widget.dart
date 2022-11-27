import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:learn_numbers/models/globals.dart' as globals;
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_numbers/bloc/bloc.dart';
import 'package:learn_numbers/bloc/state.dart';

// Кнопка выбора варианта ответа
// При нажатии генерирует событие PressButtonChoiseEvent
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
    double resize = 1;
    double height = MediaQuery.of(context).size.height;
    if (height < 600) {
      resize = 0.7;
    }
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
              duration: const Duration(microseconds: 200),
              margin: const EdgeInsets.only(top: 20, left: 40.0, right: 40.0),
              height: 48 * resize,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.grey.shade100,
                    Colors.grey.shade100,
                  ],
                ),
                boxShadow: !_isElevated
                    ? [
                        const BoxShadow(
                          color: Color(0xffccd0d3),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: Offset(4, 4),
                        ),
                        const BoxShadow(
                          color: Colors.white,
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: Offset(-4, -4),
                        ),
                      ]
                    : [
                        const BoxShadow(
                          color: Color(0xffffffff),
                          offset: Offset(-4, -4),
                          blurRadius: 5,
                          spreadRadius: 1,
                          inset: true,
                        ),
                        const BoxShadow(
                          color: Color(0xffccd0d3),
                          offset: Offset(4, 4),
                          blurRadius: 5,
                          spreadRadius: 1,
                          inset: true,
                        )
                      ],
              ),

              /// TEXT
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        state.buttonReverse
                            ? globals
                                .sortingMap[state.listButton[widget.number]]
                            : state.listButton[widget.number].toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: isGreenButton
                                ? Colors.green
                                : isRedButton
                                    ? Colors.red
                                    : Colors.black,
                            fontSize: state.page == 1
                                ? !state.buttonReverse
                                    ? 30.0 * resize
                                    : 20.0 * resize
                                : state.page == 2
                                    ? !state.buttonReverse
                                        ? 30.0 * resize
                                        : 20.0 * resize
                                    : !state.buttonReverse
                                        ? 30.0 * resize
                                        : 18.0 * resize,
                            fontWeight: state.buttonReverse
                                ? FontWeight.w500
                                : FontWeight.w700),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
