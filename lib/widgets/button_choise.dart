import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_numbers/bloc/bloc.dart';
import 'package:learn_numbers/bloc/state.dart';
import 'package:translator/translator.dart';

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
  final translator = GoogleTranslator();
  final TextEditingController tocontroller = TextEditingController();
  bool isRedButton = false;
  bool isGreenButton = false;

  _translateLang(input) {
    translator.translate(input, to: 'tr').then((resault) {
      tocontroller.text = resault.toString().toLowerCase();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBlocBloc, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (!state.buttonHelpPressed && !state.buttomPressed) {
          _translateLang(state.textButton[widget.number]);
        }
        isRedButton = state.buttonChoise == widget.number &&
            state.buttonChoise != state.truePosition &&
            state.buttomPressed;
        isGreenButton =
            state.buttonHelpPressed && state.truePosition == widget.number;
        state.buttomPressed && widget.number != state.truePosition;
        return Center(
          child: GestureDetector(
            onTap: () {
              context
                  .read<AppBlocBloc>()
                  .add(PressButtonChoiseEvent(widget.number));
            },
            child: Container(
              margin: const EdgeInsets.only(top: 20, left: 40.0, right: 40.0),
              height: 48,
              decoration: BoxDecoration(
                color: isGreenButton
                    ? Colors.green
                    : isRedButton
                        ? Colors.red
                        : Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade500,
                    spreadRadius: -1,
                    blurRadius: 8,
                    offset: const Offset(4, 4),
                  ),
                  const BoxShadow(
                    color: Colors.white,
                    spreadRadius: -2,
                    blurRadius: 8,
                    offset: Offset(-4, -4),
                  ),
                ],
              ),

              /// TEXT
              child: Center(
                child: TextField(
                  controller: tocontroller,
                  enabled: false,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  style: TextStyle(
                      // backgroundColor: Colors.grey.shade100,
                      fontSize: state.page == 1
                          ? 32.0
                          : state.page == 2
                              ? 25.0
                              : 20.0,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}