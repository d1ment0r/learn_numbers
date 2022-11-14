import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_numbers/bloc/bloc.dart';
import 'package:learn_numbers/bloc/state.dart';

class HeaderCounterWidget extends StatelessWidget {
  const HeaderCounterWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBlocBloc, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Padding(
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
        );
      },
    );
  }
}
