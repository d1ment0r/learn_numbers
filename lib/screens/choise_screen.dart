import 'dart:convert';
import 'dart:developer' as developer;
import 'package:flutter/services.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
// import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:learn_numbers/db/database.dart';
import 'package:learn_numbers/models/language.dart';
// import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:learn_numbers/models/globals.dart' as globals;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:text_to_speech/text_to_speech.dart';

import 'main_screen.dart';

TextToSpeech tts = TextToSpeech();

class ChoiseLanguageScreen extends StatefulWidget {
  const ChoiseLanguageScreen({super.key, required this.firstInit});
  final bool firstInit;

  @override
  State<ChoiseLanguageScreen> createState() => _ChoiseLanguageScreenState();
}

class _ChoiseLanguageScreenState extends State<ChoiseLanguageScreen> {
  // int _progress = 0;
  bool _isElevated = false;

  // Map embeded languages
  Language _currentLanguage = Language(
    id: 0,
    name: '',
    image: '',
    languageCode: '',
    reversMap: false,
    soundOn: true,
    volume: 1,
    rate: 1,
    pitch: 1,
  );

  Language _selectedLanguage = Language(
    id: 0,
    name: 'English (US)',
    image: 'assets/images/flags/us.png',
    languageCode: 'en-US',
    reversMap: false,
    soundOn: true,
    volume: 1,
    rate: 1,
    pitch: 1,
  );

  List<DropdownMenuItem> dropdownMenuItems = [];
  List<Language> languages = [];

  // Settings speech
  String? _languageCode;

  bool _languageChange = false;

  @override
  void initState() {
    languages = Language.getAll();
    dropdownMenuItems = buildDropdownMenuItems();
    if (widget.firstInit) {
      initializationApp();
      developer.log('initSate - firstInit');
    } else {
      _currentLanguage = (globals.currentLanguage)!;
      _selectedLanguage = (globals.currentLanguage)!;
    }
    super.initState();
  }

  // Инициализация приложения
  void initializationApp() async {
    // Read settings from db
    _currentLanguage = await DBProvider.db.getSettings();
    if (_currentLanguage.languageCode != '') {
      developer.log('_currentLanguage is not empty');
      globals.currentLanguage = _currentLanguage;
      _languageCode = _currentLanguage.languageCode;
      // считываем файл с переводом
      var jsonText =
          await rootBundle.loadString('assets/json/${_languageCode!}.json');
      Map<String, dynamic> data = json.decode(jsonText);
      // очищаем языковую карту, на случай если из настроек сменили язык
      globals.sortingMap.clear();
      // заполняем карту переводом
      data.forEach((key, value) {
        globals.sortingMap.putIfAbsent(int.parse(key), () => value.toString());
      });
      // если языковая карта заполнена, возвращаемся на главный экран
      if (globals.sortingMap.isNotEmpty) {
        if (widget.firstInit) {
          // ignore: use_build_context_synchronously
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (context) => MainScreen(
                        title: _currentLanguage.name,
                      )),
              (Route route) => false);
          await Future.delayed(const Duration(milliseconds: 500));
          FlutterNativeSplash.remove();
        } else {
          if (_languageChange) {
            // ignore: use_build_context_synchronously
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => MainScreen(
                          title: _currentLanguage.name,
                        )),
                (Route route) => false);
          } else {
            // ignore: use_build_context_synchronously
            Navigator.pop(context);
          }
        }
      }
    } else {
      _currentLanguage = _selectedLanguage;
      await Future.delayed(const Duration(seconds: 1));
      FlutterNativeSplash.remove();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isElevated) {
      Future.delayed(const Duration(milliseconds: 150), () {
        _isElevated = false;
      });
      //
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: const Color(0xFF3399CC),
      ),
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0),
        child: Column(
          children: [
            Container(
              width: 600,
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
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
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xffccd0d3),
                      spreadRadius: 1,
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
              child: DropdownButtonHideUnderline(
                child: ButtonTheme(
                    alignedDropdown: true,
                    child: DropdownButton(
                      hint: const Text('Choise language'),
                      items: dropdownMenuItems,
                      value: _selectedLanguage.id,
                      onChanged: ((value) {
                        onChangeDropdownItem(value);
                      }),
                    )),
              ),
            ),
            rowVolumeWidget(),
            rowRateWidget(),
            rowPitchWidget(),
            const SizedBox(
              height: 150.0,
            ),
            Expanded(
              child: Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () async {
                      await DBProvider.db.updateSettins(_selectedLanguage);
                      setState(() {
                        _languageChange = _currentLanguage != _selectedLanguage;
                        _isElevated = !_isElevated;
                      });
                      // Obtain shared preferences.
                      initializationApp();
                      // Navigator.of(context).pushAndRemoveUntil(
                      //     MaterialPageRoute(
                      //         builder: (context) => const MainScreen(
                      //               title: 'Turkish',
                      //             )),
                      //     (Route route) => false);
                      // ignore: use_build_context_synchronously
                    },
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        AnimatedContainer(
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
                        SvgPicture.asset('assets/images/ok_bold.svg',
                            width: 40, height: 40, color: Colors.green),
                      ],
                    ),
                  )
                  // : CircularPercentIndicator(
                  //     radius: 60.0,
                  //     lineWidth: 15.0,
                  //     percent: _progress % 1,
                  //     animation: false,
                  //     animationDuration: 1500,
                  //     center: Text(
                  //       '${_progress % 1} %',
                  //       style: const TextStyle(fontSize: 20.0),
                  //     ),
                  //     progressColor: Colors.amber[900],
                  //   ),
                  ),
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }

  Row rowPitchWidget() {
    return Row(
      children: <Widget>[
        const Text('Pitch'),
        Expanded(
          child: Slider(
            value: _currentLanguage.pitch,
            activeColor: const Color(0xFF3399CC),
            min: 0,
            max: 2,
            label: _currentLanguage.pitch.round().toString(),
            onChanged: (double value) {
              setState(() {
                _currentLanguage.pitch = value;
              });
            },
          ),
        ),
        Text('(${_currentLanguage.pitch.toStringAsFixed(2)})'),
      ],
    );
  }

  Row rowRateWidget() {
    return Row(
      children: <Widget>[
        const Text('Rate'),
        Expanded(
          child: Slider(
            value: _currentLanguage.rate,
            activeColor: const Color(0xFF3399CC),
            min: 0,
            max: 2,
            label: _currentLanguage.rate.round().toString(),
            onChanged: (double value) {
              setState(() {
                _currentLanguage.rate = value;
              });
            },
          ),
        ),
        Text('(${_currentLanguage.rate.toStringAsFixed(2)})'),
      ],
    );
  }

  Row rowVolumeWidget() {
    return Row(
      children: <Widget>[
        const Text('Volume'),
        Expanded(
          child: Slider(
            value: _currentLanguage.volume,
            activeColor: const Color(0xFF3399CC),
            min: 0,
            max: 1,
            label: _currentLanguage.volume.round().toString(),
            onChanged: (double value) {
              // initLanguages();
              setState(() {
                _currentLanguage.volume = value;
              });
            },
          ),
        ),
        Text('(${_currentLanguage.volume.toStringAsFixed(2)})'),
      ],
    );
  }

  Future<String?> getVoiceByLang(String lang) async {
    final List<String>? voices = await tts.getVoiceByLang(lang);
    if (voices != null && voices.isNotEmpty) {
      return voices.first;
    }
    return null;
  }

  onChangeDropdownItem(int id) {
    setState(() {
      _selectedLanguage = languages[id];
      _selectedLanguage.reversMap = _currentLanguage.reversMap;
      _selectedLanguage.soundOn = _currentLanguage.soundOn;
      _selectedLanguage.volume = _currentLanguage.volume;
      _selectedLanguage.rate = _currentLanguage.rate;
      _selectedLanguage.pitch = _currentLanguage.pitch;
    });
  }

  // void findLanguageUsingLoop(List languages, String languageCode) {
  //   for (var i = 0; i < languages.length; i++) {
  //     if (languages[i]['languageCode'] == languageCode) {
  //       _selectedName = languages[i]['name'];
  //       _selectedLanguage = i.toString();
  //       return;
  //     }
  //   }
  // }

  List<DropdownMenuItem> buildDropdownMenuItems() {
    List<DropdownMenuItem> items = [];
    for (var language in languages) {
      items.add(
        DropdownMenuItem(
          value: language.id,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Image.asset(
                  language.image,
                  width: 25,
                  height: 25,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(language.name)
              ],
            ),
          ),
        ),
      );
    }
    return items;
  }

  @override
  void dispose() {
    super.dispose();
  }
}
