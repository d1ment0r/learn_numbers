import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:developer' as developer;
import 'package:learn_numbers/models/globals.dart' as globals;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

class LearningScreen extends StatefulWidget {
  const LearningScreen({super.key});

  @override
  State<LearningScreen> createState() => _LearningScreenState();
}

class _LearningScreenState extends State<LearningScreen> {
  int currentStep = 0;
  final List<int> arrayUnits = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
  final List<int> arrayDecades = [10, 20, 30, 40, 50, 60, 70, 80, 90, 100];
  bool buttonLeftPush = false;
  bool buttonRightPush = false;
  bool buttonSpeechPush = false;
  bool isUnits = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<int> currentArray = [];
    if (isUnits) {
      currentArray = arrayUnits.toList();
    } else {
      currentArray = arrayDecades.toList();
    }
    if (buttonLeftPush || buttonRightPush || buttonSpeechPush) {
      Future.delayed(const Duration(milliseconds: 150), () {
        // context.read<AppBlocBloc>().add(PressButtonHelpEvent());
        setState(() {
          buttonLeftPush = false;
          buttonRightPush = false;
          buttonSpeechPush = false;
        });
      });
    }
    return Center(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 150,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isUnits = true;
                    });
                  },
                  child: Container(
                    width: 110,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 1,
                          color: isUnits
                              ? const Color(0xFF3399CC)
                              : Colors.grey.shade100),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      '0..9',
                      style: TextStyle(fontSize: 25.0),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isUnits = false;
                    });
                  },
                  child: Container(
                    width: 110,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 1,
                          color: !isUnits
                              ? const Color(0xFF3399CC)
                              : Colors.grey.shade100),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      '10..100',
                      style: TextStyle(fontSize: 25.0),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                clickOnNumber(currentArray, 0),
                clickOnNumber(currentArray, 1),
                clickOnNumber(currentArray, 2),
                clickOnNumber(currentArray, 3),
                clickOnNumber(currentArray, 4),
                clickOnNumber(currentArray, 5),
                clickOnNumber(currentArray, 6),
                clickOnNumber(currentArray, 7),
                clickOnNumber(currentArray, 8),
                clickOnNumber(currentArray, 9),
              ],
            ),
          ),
          TextNumberWidget(
              currentArray: currentArray, currentStep: currentStep),
          Flexible(
              child: Row(
            children: [
              buttonLeftWidget(),
              buttonSpeechWidget(),
              buttonRightWidget(),
            ],
          ))
        ],
      ),
    );
  }

  Flexible buttonLeftWidget() {
    return Flexible(
      child: Align(
        alignment: Alignment.center,
        child: GestureDetector(
          onTap: () {
            setState(() {
              buttonLeftPush = true;
              currentStep = currentStep > 0 ? currentStep - 1 : 9;
            });
          },
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              AnimatedContainer(
                duration: const Duration(microseconds: 200),
                height: 40.0,
                width: 40.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.grey.shade100,
                      Colors.grey.shade100,
                    ],
                  ),
                  boxShadow: !buttonLeftPush
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
              Padding(
                padding: const EdgeInsets.only(right: 4.0),
                child: SvgPicture.asset(
                  'assets/icon/left-arrow.svg',
                  width: 25,
                  height: 25,
                  color: const Color(0xFF3399CC),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Flexible buttonRightWidget() {
    return Flexible(
      child: Align(
        alignment: Alignment.center,
        child: GestureDetector(
          onTap: () {
            setState(() {
              buttonRightPush = true;
              currentStep = currentStep < 9 ? currentStep + 1 : 0;
            });
          },
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              AnimatedContainer(
                duration: const Duration(microseconds: 200),
                height: 40.0,
                width: 40.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.grey.shade100,
                      Colors.grey.shade100,
                    ],
                  ),
                  boxShadow: !buttonRightPush
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
              Padding(
                padding: const EdgeInsets.only(left: 6.0),
                child: SvgPicture.asset(
                  'assets/icon/right-arrow.svg',
                  width: 25,
                  height: 25,
                  color: const Color(0xFF3399CC),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Flexible buttonSpeechWidget() {
    return Flexible(
      child: Align(
        alignment: Alignment.center,
        child: GestureDetector(
          onTap: () {
            setState(() {
              buttonSpeechPush = true;
            });
          },
          child: AnimatedContainer(
            duration: const Duration(microseconds: 200),
            height: 60.0,
            width: 60.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.grey.shade100,
                  Colors.grey.shade100,
                ],
              ),
              boxShadow: !buttonSpeechPush
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
        ),
      ),
    );
  }

  GestureDetector clickOnNumber(List<int> currentArray, int numer) {
    return GestureDetector(
      onTap: () => setState(() {
        currentStep = numer;
      }),
      child: StepNumericWidget(
        currentArray: currentArray,
        currentStep: currentStep,
        step: numer,
      ),
    );
  }
}

class ButtonLeftWidget extends StatelessWidget {
  const ButtonLeftWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Align(
        alignment: Alignment.center,
        child: AnimatedContainer(
          duration: const Duration(microseconds: 200),
          height: 40.0,
          width: 40.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.grey.shade100,
                  Colors.grey.shade100,
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0xffccd0d3),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(4, 4),
                ),
                BoxShadow(
                  color: Colors.white,
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(-4, -4),
                ),
              ]),
        ),
      ),
    );
  }
}

class ButtonRightWidget extends StatelessWidget {
  const ButtonRightWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Align(
        alignment: Alignment.center,
        child: Container(
          height: 40.0,
          width: 40.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.grey.shade100,
                  Colors.grey.shade100,
                ],
              ),
              boxShadow: const [
                BoxShadow(
                  color: Color(0xffccd0d3),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(4, 4),
                ),
                BoxShadow(
                  color: Colors.white,
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(-4, -4),
                ),
              ]),
        ),
      ),
    );
  }
}

class ButtonSpeechWidget extends StatelessWidget {
  const ButtonSpeechWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Align(
        alignment: Alignment.center,
        child: Container(
          height: 60.0,
          width: 60.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.grey.shade100,
                  Colors.grey.shade100,
                ],
              ),
              boxShadow: const [
                BoxShadow(
                  color: Color(0xffccd0d3),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(4, 4),
                ),
                BoxShadow(
                  color: Colors.white,
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(-4, -4),
                ),
              ]),
        ),
      ),
    );
  }
}

class TextNumberWidget extends StatelessWidget {
  const TextNumberWidget({
    Key? key,
    required this.currentArray,
    required this.currentStep,
  }) : super(key: key);

  final List<int> currentArray;
  final int currentStep;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              globals.sortingMap[currentArray[currentStep]],
              style: TextStyle(fontSize: 30.0),
            ),
          ],
        ),
      ),
    );
  }
}

class StepNumericWidget extends StatelessWidget {
  const StepNumericWidget({
    Key? key,
    required this.currentArray,
    required this.currentStep,
    required this.step,
  }) : super(key: key);

  final List<int> currentArray;
  final int currentStep;
  final int step;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: step == currentStep ? 60.0 : 25.0,
      decoration: BoxDecoration(
        border: Border.all(
          width: step == currentStep ? 2 : 1,
          color: step == currentStep
              ? const Color(0xFF3399CC)
              : const Color(0xFF999999),
        ),
        borderRadius: step == currentStep
            ? BorderRadius.circular(10)
            : BorderRadius.circular(5),
        // color: const Color(0xFF999999),
      ),
      child: Center(
        child: Padding(
          padding: (currentArray[step] < 10)
              ? EdgeInsets.only(
                  left: step == currentStep ? 15.0 : 3.0,
                  right: step == currentStep ? 15.0 : 3.0)
              : EdgeInsets.only(
                  left: step == currentStep ? 5.0 : 1.0,
                  right: step == currentStep ? 5.0 : 1.0),
          child: Text(
            currentArray[step].toString(),
            style: TextStyle(
                color: step == currentStep
                    ? Colors.black
                    : const Color(0xFF999999),
                // fontSize: step == currentStep ? 50.0 : 20.0),
                fontSize: step == currentStep ? 50.0 : 18.0),
          ),
        ),
      ),
    );
  }
}
