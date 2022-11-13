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
  bool isTrueButton = false;

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
        if (!state.buttonHelpPressed) {
          _translateLang(state.textButton[widget.number]);
          isTrueButton = false;
        } else {
          isTrueButton = state.truePosition == widget.number;
        }
        print('button choise');
        return Center(
          child: GestureDetector(
            onTap: () {
              context.read<AppBlocBloc>().add(
                  PressButtonChoiseEvent(state.truePosition == widget.number));
            },
            child: Container(
              margin: const EdgeInsets.only(top: 20, left: 40.0, right: 40.0),
              height: 48,
              decoration: BoxDecoration(
                color: isTrueButton ? Colors.green : Colors.grey[200],
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
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
