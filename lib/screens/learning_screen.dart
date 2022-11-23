import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:learn_numbers/models/globals.dart' as globals;
import 'package:learn_numbers/models/language.dart';
import 'package:text_to_speech/text_to_speech.dart';
import 'dart:developer' as developer;

TextToSpeech tts = TextToSpeech();

class LearningScreen extends StatefulWidget {
  const LearningScreen({super.key});

  @override
  State<LearningScreen> createState() => _LearningScreenState();
}

class _LearningScreenState extends State<LearningScreen> {
  int _currentStep = 0;
  final List<int> _arrayNumbers = [
    0,
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    20,
    30,
    40,
    50,
    60,
    70,
    80,
    90,
    100
  ];
  bool _speechButtonOn = false;

  @override
  void initState() {
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

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              rowNumbersWidget(0),
              dividerWidget(),
              rowNumbersWidget(1),
              dividerWidget(),
              rowNumbersWidget(2),
              dividerWidget(),
              rowNumbersWidget(3),
              dividerWidget(),
              rowNumbersWidget(4),
              dividerWidget(),
              rowNumbersWidget(5),
              dividerWidget(),
              rowNumbersWidget(6),
              dividerWidget(),
              rowNumbersWidget(7),
              dividerWidget(),
              rowNumbersWidget(8),
              dividerWidget(),
              rowNumbersWidget(9),
              dividerWidget(),
              rowNumbersWidget(10),
              dividerWidget(),
              rowNumbersWidget(11),
              dividerWidget(),
              rowNumbersWidget(12),
              dividerWidget(),
              rowNumbersWidget(13),
              dividerWidget(),
              rowNumbersWidget(14),
              dividerWidget(),
              rowNumbersWidget(15),
              dividerWidget(),
              rowNumbersWidget(16),
              dividerWidget(),
              rowNumbersWidget(17),
              dividerWidget(),
              rowNumbersWidget(18),
              dividerWidget(),
              rowNumbersWidget(19),
            ],
          ),
        ],
      ),
    );
  }

  Padding rowNumbersWidget(int step) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 15.0, top: 7.0, bottom: 7.0, right: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 7.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _arrayNumbers[step].toString().padLeft(3, ' '),
                      style: const TextStyle(fontSize: 18.0),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  globals.sortingMap[_arrayNumbers[step]],
                  style: const TextStyle(fontSize: 20.0),
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              developer.log(_arrayNumbers[step].toString());
              setState(() {
                _speechButtonOn = true;
                _currentStep = step;
              });
              speak(globals.sortingMap[_arrayNumbers[step]]);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              child: SvgPicture.asset(
                'assets/images/sound_on.svg',
                width: 20,
                height: 20,
                color: _speechButtonOn && step == _currentStep
                    ? const Color(0xFF3399CC)
                    : Colors.black,
              ),
            ),
          )
        ],
      ),
    );
  }
}

Divider dividerWidget() {
  return const Divider(
    height: 2,
    indent: 10.0,
    endIndent: 10.0,
    thickness: 2,
  );
}

Future<void> speak(sayText) async {
  List<String> languages = <String>[];
  List<String> languageCodes = <String>[];
  Language? language = globals.currentLanguage;

  // populate lang code (i.e. en-US)
  languageCodes = await tts.getLanguages();

  // populate displayed language (i.e. English)
  final List<String>? displayLanguages = await tts.getDisplayLanguages();
  if (displayLanguages == null) {
    return;
  }

  languages.clear();
  for (final dynamic lang in displayLanguages) {
    languages.add(lang as String);
  }

  final String? defaultLangCode = await tts.getDefaultLanguage();

  if (language!.languageCode != '' &&
      !languageCodes.contains(language.languageCode)) {
    if (language.languageCode != '' &&
        languageCodes.contains(defaultLangCode)) {
      globals.languageCode = defaultLangCode;
    }
  }
  // final String? language =
  //     await tts.getDisplayLanguageByCode(language.languageCode);

  tts.setVolume(language.volume);
  tts.setRate(language.rate);
  if (language.languageCode != '') {
    tts.setLanguage(language.languageCode);
  } else {
    tts.setLanguage(defaultLangCode!);
  }
  tts.setPitch(globals.pitch);
  await Future.delayed(const Duration(milliseconds: 500));
  tts.speak(sayText);
}
