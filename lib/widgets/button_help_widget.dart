import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:learn_numbers/bloc/bloc.dart';
import 'package:learn_numbers/bloc/state.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'dart:developer' as developer;

class ButtonHelpWidget extends StatefulWidget {
  const ButtonHelpWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<ButtonHelpWidget> createState() => _ButtonHelpWidgetState();
}

class _ButtonHelpWidgetState extends State<ButtonHelpWidget> {
  bool _isElevated = false;

  @override
  Widget build(BuildContext context) {
    if (_isElevated) {
      Future.delayed(const Duration(milliseconds: 150), () {
        context.read<AppBlocBloc>().add(PressButtonHelpEvent());
        _isElevated = false;
      });
      //
    }
    // Full screen width
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    // developer.log('width screen: $width height: $height');
    double rigthPaddingValue = width / 18;

    return Flexible(
      child: BlocConsumer<AppBlocBloc, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Align(
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () {
                developer.log('press help button');
                setState(() {
                  _isElevated = true;
                });
              },
              child: Padding(
                padding: EdgeInsets.only(right: rigthPaddingValue),
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(microseconds: 200),
                      height: 40.0,
                      width: 40.0,
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
                                  spreadRadius: 2,
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
                                ),
                              ],
                      ),
                    ),
                    SvgPicture.asset(
                      'assets/images/help_ok.svg',
                      width: 22,
                      height: 22,
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
