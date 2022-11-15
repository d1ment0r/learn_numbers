import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
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
                  context.read<AppBlocBloc>().add(PressButtonReversEvent());
                },
                child: Container(
                  height: 30.0,
                  width: 30.0,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(25),
                    image: const DecorationImage(
                      image: Svg('assets/images/rotate.svg',
                          size: Size(22.0, 22.0), color: Colors.black),
                    ),
                    boxShadow: state.buttonReverse
                        ? [
                            BoxShadow(
                              color: Colors.grey.shade500,
                              spreadRadius: 2,
                              blurRadius: 1,
                              offset: const Offset(2, 2),
                            ),
                            const BoxShadow(
                              color: Colors.white,
                              spreadRadius: 2,
                              blurRadius: 1,
                              offset: Offset(-2, -2),
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
