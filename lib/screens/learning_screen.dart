import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter/services.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:learn_numbers/core/speech.dart';
import 'package:learn_numbers/models/globals.dart' as globals;
import 'package:learn_numbers/models/language.dart';
import 'package:number_to_words/number_to_words.dart';
import 'package:text_to_speech/text_to_speech.dart';
import 'dart:developer' as developer;

import 'package:translator/translator.dart';

TextToSpeech tts = TextToSpeech();

class LearningScreen extends StatefulWidget {
  const LearningScreen({super.key});

  @override
  State<LearningScreen> createState() => _LearningScreenState();
}

class _LearningScreenState extends State<LearningScreen>
    with TickerProviderStateMixin {
  int _currentStep = 0;
  bool _isElevated = false;
  List<int> arrayNumbers = [];
  bool _speechButtonOn = false;
  String _customTranslate = '';
  bool _customTranslateRun = false;
  final searchController = TextEditingController();
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat(reverse: true);
    fillArrayNumbers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_speechButtonOn) {
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          _speechButtonOn = false;
        });
      });
    }
    if (_isElevated) {
      Future.delayed(const Duration(milliseconds: 150), () {
        developer.log('press 0 button');
        setState(() {
          _isElevated = false;
        });
      });
      //
    }
    if (_customTranslateRun) {
      Future.delayed(const Duration(milliseconds: 250), () {
        setState(() {
          _customTranslateRun = false;
        });
      });
    }

    return Column(
      children: [
        topRowWidget(),
        if (searchController.text.length > 3)
          Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(left: 15.0, right: 25.0, bottom: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Text(
                            arrayNumbers[0].toString(),
                            style: const TextStyle(fontSize: 18.0),
                            // textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                      // ),
                    ),
                    _customTranslateRun
                        ? CircularProgressIndicator(
                            value: controller.value,
                            strokeWidth: 2.0,
                            semanticsLabel: 'Get tranlate ...',
                          )
                        : Flexible(
                            child: Text(
                            _customTranslate,
                            textAlign: TextAlign.start,
                            style: const TextStyle(fontSize: 20.0),
                          )),
                    if (globals.voice != null && globals.voice != '')
                      GestureDetector(
                          onTap: () {
                            developer.log(arrayNumbers[0].toString());
                            setState(() {
                              _speechButtonOn = true;
                              _currentStep = 0;
                            });
                            speech(arrayNumbers[0].toString(), 4);
                          },
                          child: buttonSpeechNumer(0)),
                  ],
                ),
              ),
              dividerWidget(),
            ],
          ),
        if (searchController.text.length < 4)
          Expanded(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            child: ListView.builder(
              itemCount: arrayNumbers.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    rowNumbersWidget(index),
                    dividerWidget(),
                  ],
                );
              },
            ),
          ),
      ],
    );
  }

  Container topRowWidget() {
    return Container(
      margin: const EdgeInsets.only(
          top: 15.0, left: 16.0, right: 16.0, bottom: 8.0),
      child: Row(
        children: [
          searchFieldWidget(),
          buttonAddZeroWidget(),
        ],
      ),
    );
  }

  GestureDetector buttonAddZeroWidget() {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (searchController.text.length < 5) {
            searchController.text = '${searchController.text}0';
            searchNumber(searchController.text);
          }
          _isElevated = true;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(microseconds: 150),
        width: 45.0,
        height: 45.0,
        margin: const EdgeInsets.only(left: 34, right: 6.0, bottom: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              '0',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Flexible searchFieldWidget() {
    return Flexible(
      child: TextField(
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        controller: searchController,
        keyboardType: TextInputType.number,
        maxLength: 5,
        style: const TextStyle(fontSize: 18.0),
        decoration: InputDecoration(
          // отключает счетчик введённых цифр
          // counter: const Offstage(),
          prefixIcon: const Icon(Icons.search),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                searchController.clear();
                fillArrayNumbers();
              });
            },
            icon: Icon(Icons.close,
                color: searchController.text.isNotEmpty
                    ? Colors.black
                    : Colors.grey[200],
                size: 20.0),
          ),
          hintText: 'Search number',
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.grey.shade600,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Color(0xFF3399CC),
            ),
          ),
        ),
        onChanged: searchNumber,
      ),
    );
  }

  GestureDetector rowNumbersWidget(int step) {
    return GestureDetector(
      onTap: () {
        if (globals.voice != null && globals.voice != '') {
          developer.log(arrayNumbers[step].toString());
          setState(() {
            _speechButtonOn = true;
            _currentStep = step;
          });
          if (searchController.text.length < 4) {
            speech(arrayNumbers[step].toString(), 4);
          } else {
            speech(arrayNumbers[0].toString(), 4);
          }
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(
            left: 15.0, top: 7.0, bottom: 7.0, right: 25.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Text(
                    arrayNumbers[step].toString().padLeft(3, ' '),
                    style: const TextStyle(fontSize: 18.0),
                    // textAlign: TextAlign.left,
                  ),
                ),
              ],
              // ),
            ),
            Expanded(
              child: Text(
                globals.sortingMap[arrayNumbers[step]],
                style: const TextStyle(fontSize: 20.0),
                textAlign: TextAlign.left,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 5.0),
            ),
            if (globals.voice != null && globals.voice != '')
              buttonSpeechNumer(step),
          ],
        ),
      ),
    );
  }

  Stack buttonSpeechNumer(int step) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        const SizedBox(
          width: 30,
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 3,
            top: 5,
          ),
          child: SvgPicture.asset(
            'assets/icon/sound_on.svg',
            width: 22,
            height: 22,
            color: _speechButtonOn && step == _currentStep
                ? Colors.grey.shade200
                : Colors.grey.shade400,
          ),
        ),
        // ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          child: SvgPicture.asset('assets/icon/sound_on.svg',
              width: _speechButtonOn && step == _currentStep ? 24 : 20,
              height: _speechButtonOn && step == _currentStep ? 24 : 20,
              color: Colors.black),
        ),
      ],
    );
  }

  void searchNumber(String query) {
    if (query.length < 4) {
      fillArrayNumbers();
      final suggestions = arrayNumbers.where((numer) {
        final numerAsString = numer.toString();
        return numerAsString.contains(query);
      }).toList();
      setState(() {
        arrayNumbers = suggestions;
      });
    } else {
      int numer = int.parse(query);
      setState(() {
        _customTranslateRun = true;
        _customTranslate = '';
      });
      getTranslate(numer);
    }
  }

  Future<void> getTranslate(numer) async {
    final translator = GoogleTranslator();
    final List<int> suggestions = [numer];
    Language language = globals.currentLanguage!;
    String translate = '';
    String english =
        numer > 0 ? NumberToWord().convert('en-in', numer) : 'zero';
    String translateCode = language.translateCode;
    await translator.translate(english, to: translateCode).then((result) {
      translate = result.toString().toLowerCase();
    });
    setState(() {
      arrayNumbers = suggestions;
      _customTranslate = translate;
    });
  }

  void fillArrayNumbers() {
    arrayNumbers.clear();
    globals.sortingMap.forEach((key, value) {
      arrayNumbers.add(key);
    });
  }
}

Divider dividerWidget() {
  return const Divider(
    height: 0,
    indent: 20.0,
    endIndent: 20.0,
    thickness: 1,
    color: Color(0xFF3399CC),
  );
}
