import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter/services.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
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
  bool _isElevated = false;
  List<int> arrayNumbers = [];
  bool _speechButtonOn = false;
  final searchController = TextEditingController();

  @override
  void initState() {
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
        developer.log('press +0 button');
        setState(() {
          _isElevated = false;
        });
      });
      //
    }

    return Column(
      children: [
        topRowWidget(),
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
              }),
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
          if (searchController.text.length < 3) {
            searchController.text = '${searchController.text}0';
            searchNumber(searchController.text);
          }
          _isElevated = true;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(microseconds: 150),
        width: 32.0,
        height: 32.0,
        margin: const EdgeInsets.only(left: 48, right: 6.0),
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
              '+0',
              style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
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
        maxLength: 3,
        style: const TextStyle(fontSize: 18.0),
        decoration: InputDecoration(
          counter: const Offstage(),
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
        developer.log(arrayNumbers[step].toString());
        setState(() {
          _speechButtonOn = true;
          _currentStep = step;
        });
        speak(globals.sortingMap[arrayNumbers[step]]);
      },
      child: Padding(
        padding: const EdgeInsets.only(
            left: 15.0, top: 7.0, bottom: 7.0, right: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 7.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        arrayNumbers[step].toString().padLeft(3, ' '),
                        style: const TextStyle(fontSize: 18.0),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    globals.sortingMap[arrayNumbers[step]],
                    style: const TextStyle(fontSize: 20.0),
                  ),
                ),
              ],
            ),
            AnimatedContainer(
              padding: const EdgeInsets.only(right: 10),
              duration: const Duration(milliseconds: 500),
              child: SvgPicture.asset(
                'assets/icon/sound_on.svg',
                width: 20,
                height: 20,
                color: _speechButtonOn && step == _currentStep
                    ? const Color(0xFF3399CC)
                    : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void searchNumber(String query) {
    fillArrayNumbers();
    final suggestions = arrayNumbers.where((numer) {
      final numerAsString = numer.toString();
      return numerAsString.contains(query);
    }).toList();

    setState(() {
      arrayNumbers = suggestions;
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

Future<void> speak(sayText) async {
  String voice = '';
  List<String> languageCodes = <String>[];
  Language? language = globals.currentLanguage;

  // populate lang code (i.e. en-US)
  languageCodes = await tts.getLanguages();

  // populate displayed language (i.e. English)
  final List<String>? displayLanguages = await tts.getDisplayLanguages();
  if (displayLanguages == null) {
    return;
  }

  final String? defaultLangCode = await tts.getDefaultLanguage();

  if (language!.voice != '' && languageCodes.contains(language.voice)) {
    voice = language.voice;
  } else {
    voice = defaultLangCode.toString();
  }
  // final String? language =
  //     await tts.getDisplayLanguageByCode(language.languageCode);

  tts.setVolume(language.volume);
  tts.setRate(language.rate);
  if (voice != '') {
    tts.setLanguage(voice);
  } else {
    tts.setLanguage(defaultLangCode!);
  }
  tts.setPitch(globals.pitch);
  await Future.delayed(const Duration(milliseconds: 500));
  tts.speak(sayText);
}
