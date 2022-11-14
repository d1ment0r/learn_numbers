import 'package:flutter/material.dart';
import 'dart:developer' as developer;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_numbers/bloc/bloc.dart';
import 'package:learn_numbers/bloc/state.dart';

class TargetTextWinget extends StatelessWidget {
  const TargetTextWinget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBlocBloc, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state.buttomPressed) {
          Future.delayed(const Duration(milliseconds: 1200), () {
            developer.log('Function - updateScreenData');
            context.read<AppBlocBloc>().add(UpdateScreenEvent());
          });
        }
        return Container(
          margin: const EdgeInsets.all(0),
          child: Text(
            state.target.toString(),
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: state.page == 1
                    ? 160.0
                    : state.page == 2
                        ? 155.0
                        : 150.0),
          ),
        );
      },
    );
  }
}
