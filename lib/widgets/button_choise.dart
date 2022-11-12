import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_numbers/bloc/bloc.dart';
import 'package:learn_numbers/bloc/state.dart';

class ButtonChoiseWidget extends StatelessWidget {
  const ButtonChoiseWidget({
    super.key,
    required this.number,
  });

  final int number;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBlocBloc, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Center(
          child: GestureDetector(
            onTap: () {
              context
                  .read<AppBlocBloc>()
                  .add(PressButtonChoiseEvent(state.truePosition == number));
            },
            child: Container(
              margin: const EdgeInsets.only(top: 20, left: 40.0, right: 40.0),
              height: 48,
              decoration: BoxDecoration(
                color: state.buttomPressed ? Colors.green : Colors.grey[200],
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
              child: Center(
                  child: Text(
                state.textButton[number],
                style: TextStyle(
                    fontSize: state.page == 1
                        ? 32.0
                        : state.page == 2
                            ? 25.0
                            : 20.0,
                    fontWeight: FontWeight.w400),
              )),
            ),
          ),
        );
      },
    );
  }
}
