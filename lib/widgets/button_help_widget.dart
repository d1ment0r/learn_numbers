import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_numbers/bloc/bloc.dart';
import 'package:learn_numbers/bloc/state.dart';

class ButtonHelpWidget extends StatelessWidget {
  const ButtonHelpWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: BlocConsumer<AppBlocBloc, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: () {
                context
                    .read<AppBlocBloc>()
                    .add(PressButtonHelpEvent(state.target));
              },
              child: Container(
                height: 50.0,
                width: 50.0,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(25),
                  // image: const DecorationImage(
                  // image: SvgPicture(
                  //   'assets/images/help_ok.svg',
                  //   size: Size(25.0, 25.0),
                  //   color: Color(0xFF3399CC),
                  // ),
                  // ),
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
              ),
            ),
          );
        },
      ),
    );
  }
}
