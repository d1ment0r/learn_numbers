import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter/services.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:learn_numbers/core/speech.dart';
import 'package:learn_numbers/models/globals.dart' as globals;
import 'package:learn_numbers/models/language.dart';
import 'package:learn_numbers/themes/theme.dart';
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
  String customTranslate = '';
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
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    checkPressButtonSpeech();
    checkPressButtonAddZero();

    return Column(
      children: [
        topRowWidget(),
        arrayNumbers.isEmpty
            ? CircularProgressIndicator(
                value: controller.value,
                strokeWidth: 2.0,
                semanticsLabel: 'Get tranlate ...',
              )
            : Expanded(
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

  void checkPressButtonAddZero() {
    if (_isElevated) {
      Future.delayed(
        const Duration(milliseconds: 150),
        () {
          developer.log('press 0 button');
          setState(() {
            _isElevated = false;
          });
        },
      );
    }
  }

  void checkPressButtonSpeech() {
    if (_speechButtonOn) {
      Future.delayed(
        const Duration(seconds: 1),
        () {
          setState(() {
            _speechButtonOn = false;
          });
        },
      );
    }
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
    // Темная тема
    bool isDark = ThemeModelInheritedNotifier.of(context).theme.brightness ==
        Brightness.dark;
    return GestureDetector(
      onTap: () {
        setState(
          () {
            if (searchController.text.length < 5) {
              searchController.text = '${searchController.text}0';
              searchNumber(searchController.text);
            }
            _isElevated = true;
          },
        );
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
              isDark ? darkAppColors : lithAppColors,
              isDark ? darkAppColors : lithAppColors,
            ],
          ),
          boxShadow: !_isElevated
              ? [
                  BoxShadow(
                    color: isDark ? darkAppShadowBottom : lithAppShadowBottom,
                    spreadRadius: 2,
                    blurRadius: 6,
                    offset: const Offset(4, 4),
                  ),
                  BoxShadow(
                    color: isDark ? darkAppShadowTop : lithAppShadowTop,
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(-3, -3),
                  ),
                ]
              : [
                  BoxShadow(
                    color: isDark ? darkAppShadowTop : lithAppShadowTop,
                    offset: const Offset(-4, -4),
                    blurRadius: 5,
                    spreadRadius: 1,
                    inset: true,
                  ),
                  BoxShadow(
                    color: isDark ? darkAppShadowBottom : lithAppShadowBottom,
                    offset: const Offset(4, 4),
                    blurRadius: 5,
                    spreadRadius: 1,
                    inset: true,
                  ),
                ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '0',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w600,
                color: isDark ? darkAppTextColor : lithAppTextColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Flexible searchFieldWidget() {
    bool isDark = ThemeModelInheritedNotifier.of(context).theme.brightness ==
        Brightness.dark;
    return Flexible(
      child: TextField(
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        controller: searchController,
        keyboardType: TextInputType.number,
        maxLength: 5,
        style: TextStyle(
          fontSize: 18.0,
          color: isDark ? darkAppTextColor : lithAppTextColor,
        ),
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
    bool isDark = ThemeModelInheritedNotifier.of(context).theme.brightness ==
        Brightness.dark;
    return GestureDetector(
      onTap: () {
        if (globals.voice != null && globals.voice != '') {
          developer.log(arrayNumbers[step].toString());
          setState(() {
            _speechButtonOn = true;
            _currentStep = step;
          });
          speech(arrayNumbers[step].toString(), 4);
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
                    style: TextStyle(
                      fontSize: 18.0,
                      color: isDark ? darkAppTextColor : lithAppTextColor,
                    ),
                    // textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
            Expanded(
              child: Text(
                arrayNumbers[step] < 1000
                    ? globals.sortingMap[arrayNumbers[step]]
                    : customTranslate,
                style: TextStyle(
                  fontSize: 20.0,
                  color: isDark ? darkAppTextColor : lithAppTextColor,
                ),
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
    bool isDark = ThemeModelInheritedNotifier.of(context).theme.brightness ==
        Brightness.dark;
    return Stack(alignment: AlignmentDirectional.center, children: [
      AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        width: _speechButtonOn && step == _currentStep ? 27 : 24,
        height: _speechButtonOn && step == _currentStep ? 27 : 24,
        margin: EdgeInsets.only(
            top: _speechButtonOn && step == _currentStep ? 0.0 : 3.0,
            bottom: 3.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              isDark ? darkAppColors : lithAppColors,
              isDark ? darkAppColors : lithAppColors,
            ],
          ),
          boxShadow: _speechButtonOn && step == _currentStep
              ? [
                  BoxShadow(
                    color: isDark ? darkAppShadowTop : lithAppShadowTop,
                    offset: const Offset(-3, -3),
                    blurRadius: 5,
                    spreadRadius: 1,
                    inset: true,
                  ),
                  BoxShadow(
                    color: isDark ? darkAppShadowBottom : lithAppShadowBottom,
                    offset: const Offset(3, 3),
                    blurRadius: 5,
                    spreadRadius: 1,
                    inset: true,
                  ),
                ]
              : [
                  BoxShadow(
                    color: isDark ? darkAppShadowBottom : lithAppShadowBottom,
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(3, 3),
                  ),
                  BoxShadow(
                    color: isDark ? darkAppShadowTop : lithAppShadowTop,
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(-3, -3),
                  ),
                ],
          // :
        ),
      ),
      SvgPicture.asset(
        'assets/icon/sound_on.svg',
        // width: _speechButtonOn && step == _currentStep ? 10 : 10,
        // height: _speechButtonOn && step == _currentStep ? 10 : 10,
        height: 16,
        width: 16,
        color: isDark ? darkAppTextColor : lithAppTextColor,
      ),
    ]);
    //   ],
    // );
  }

  void searchNumber(String query) {
    int numer = query.isNotEmpty ? int.parse(query) : 0;
    if (query.length < 3) {
      fillArrayNumbers();
      final suggestions = arrayNumbers.where((numer) {
        final numerAsString = numer.toString();
        return numerAsString.contains(query);
      }).toList();
      setState(() {
        arrayNumbers = suggestions;
      });
    } else if (query.length == 3) {
      arrayNumbers = [numer];
    } else {
      arrayNumbers = [numer];
      if (numer > 999) {
        getTranslate(numer);
      }
    }
  }

  Future<void> getTranslate(int numer) async {
    final translator = GoogleTranslator();
    // final List<int> suggestions = [numer];
    Language language = globals.currentLanguage;
    String english =
        numer > 0 ? NumberToWord().convert('en-in', numer) : 'zero';
    String translateCode = language.translateCode;
    await translator.translate(english, to: translateCode).then((result) {
      setState(() {
        customTranslate = result.toString().toLowerCase();
        developer.log(
            'Learning screen: getTranslate _customTranslate $customTranslate for ${arrayNumbers[0]}');
      });
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
