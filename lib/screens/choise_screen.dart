import 'dart:convert';
import 'dart:developer' as developer;
import 'package:flutter/services.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
// import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_svg/flutter_svg.dart';
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
  String? _selectedLanguage;
  String? _selectedName;
  final List<Map> _languageJson = [
    {
      'id': '0',
      'name': 'English (US)',
      'image': 'assets/images/flags/us.png',
      'languageCode': 'en-US'
    },
    {
      'id': '1',
      'name': 'Malay',
      'image': 'assets/images/flags/ms.png',
      'languageCode': 'ms-MY'
    },
    {
      'id': '2',
      'name': 'Français (France)',
      'image': 'assets/images/flags/fr.png',
      'languageCode': 'fr-FR'
    },
    {
      'id': '3',
      'name': 'Türkçe',
      'image': 'assets/images/flags/tr.png',
      'languageCode': 'tr-TR'
    },
    {
      'id': '4',
      'name': 'Deutsch',
      'image': 'assets/images/flags/de.png',
      'languageCode': 'de-DE'
    },
    {
      'id': '5',
      'name': '中文 (台灣)',
      'image': 'assets/images/flags/jp.png',
      'languageCode': 'ja-JP'
    },
    {
      'id': '6',
      'name': 'Italiano',
      'image': 'assets/images/flags/it.png',
      'languageCode': 'it-IT'
    },
    {
      'id': '7',
      'name': 'Русский',
      'image': 'assets/images/flags/ru.png',
      'languageCode': 'ru-RU'
    },
    {
      'id': '8',
      'name': 'Українська',
      'image': 'assets/images/flags/ua.png',
      'languageCode': 'uk-UA'
    }
  ];

  List<DropdownMenuItem> dropdownMenuItems = [];

  // Settings speech
  String? _languageCode = globals.languageCode;
  double _volume = globals.volume; // Range: 0-1
  double _rate = globals.rate; // Range: 0-2
  double _pitch = globals.pitch; // Range: 0-2

  @override
  void initState() {
    dropdownMenuItems = buildDropdownMenuItems(_languageJson);
    if (widget.firstInit) {
      initializationApp();
    }
    super.initState();
  }

  void initializationApp() async {
    // Obtain shared preferences.
    final prefs = await SharedPreferences.getInstance();
    // Read data
    _languageCode = prefs.getString('languageCode');
    if (_languageCode != null) {
      developer.log('_languageCode is null');
      globals.languageCode = _languageCode;
      findLanguageUsingLoop(_languageJson, _languageCode!);
      globals.volume = prefs.getDouble('volume') ?? 1;
      globals.rate = prefs.getDouble('rate') ?? 1;
      globals.pitch = prefs.getDouble('pitch') ?? 1;
      var jsonText =
          await rootBundle.loadString('assets/json/${_languageCode!}.json');
      Map<String, dynamic> data = json.decode(jsonText);
      // очищаем языковую карту
      globals.sortingMap.clear();
      data.forEach((key, value) {
        globals.sortingMap.putIfAbsent(int.parse(key), () => value.toString());
      });
      if (globals.sortingMap.isNotEmpty) {
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => MainScreen(
                      title: _selectedName!,
                    )),
            (Route route) => false);
        await Future.delayed(const Duration(milliseconds: 500));
        FlutterNativeSplash.remove();
      }
    } else {
      await Future.delayed(const Duration(seconds: 1));
      FlutterNativeSplash.remove();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.firstInit) {
      findLanguageUsingLoop(_languageJson, _languageCode!);
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
                      value: _selectedLanguage,
                      onChanged: ((value) {
                        onChangeDropdownItem(value);
                      }),
                    )),
              ),
            ),
            Row(
              children: <Widget>[
                const Text('Volume'),
                Expanded(
                  child: Slider(
                    value: _volume,
                    activeColor: const Color(0xFF3399CC),
                    min: 0,
                    max: 1,
                    label: _volume.round().toString(),
                    onChanged: (double value) {
                      // initLanguages();
                      setState(() {
                        _volume = value;
                      });
                    },
                  ),
                ),
                Text('(${_volume.toStringAsFixed(2)})'),
              ],
            ),
            Row(
              children: <Widget>[
                const Text('Rate'),
                Expanded(
                  child: Slider(
                    value: _rate,
                    activeColor: const Color(0xFF3399CC),
                    min: 0,
                    max: 2,
                    label: _rate.round().toString(),
                    onChanged: (double value) {
                      setState(() {
                        _rate = value;
                      });
                    },
                  ),
                ),
                Text('(${_rate.toStringAsFixed(2)})'),
              ],
            ),
            Row(
              children: <Widget>[
                const Text('Pitch'),
                Expanded(
                  child: Slider(
                    value: _pitch,
                    activeColor: const Color(0xFF3399CC),
                    min: 0,
                    max: 2,
                    label: _pitch.round().toString(),
                    onChanged: (double value) {
                      setState(() {
                        _pitch = value;
                      });
                    },
                  ),
                ),
                Text('(${_pitch.toStringAsFixed(2)})'),
              ],
            ),
            const SizedBox(
              height: 150.0,
            ),
            Expanded(
              child: Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () async {
                      if (_languageCode != null) {
                        setState(() {
                          _isElevated = !_isElevated;
                        });
                        // Obtain shared preferences.
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setDouble('volume', _volume);
                        await prefs.setDouble('rate', _rate);
                        await prefs.setDouble('pitch', _pitch);
                        await prefs.setString('languageCode', _languageCode!);
                        initializationApp();
                        // Navigator.of(context).pushAndRemoveUntil(
                        //     MaterialPageRoute(
                        //         builder: (context) => const MainScreen(
                        //               title: 'Turkish',
                        //             )),
                        //     (Route route) => false);
                        // ignore: use_build_context_synchronously
                      }
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
                        SvgPicture.asset(
                          'assets/images/ok_bold.svg',
                          width: 40,
                          height: 40,
                          color: _languageCode != null
                              ? Colors.green
                              : Colors.grey,
                        ),
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

  Future<String?> getVoiceByLang(String lang) async {
    final List<String>? voices = await tts.getVoiceByLang(lang);
    if (voices != null && voices.isNotEmpty) {
      return voices.first;
    }
    return null;
  }

  onChangeDropdownItem(String id) {
    setState(() {
      _selectedLanguage = id;
      _languageCode = _languageJson[int.parse(id)]['languageCode'];
      _selectedName = _languageJson[int.parse(id)]['name'];
      // selectedDictionary = selectedCompany.dictionary;
    });
  }

  void findLanguageUsingLoop(List languages, String languageCode) {
    for (var i = 0; i < languages.length; i++) {
      if (languages[i]['languageCode'] == languageCode) {
        _selectedName = languages[i]['name'];
        _selectedLanguage = i.toString();
        return;
      }
    }
  }

  List<DropdownMenuItem> buildDropdownMenuItems(List languages) {
    List<DropdownMenuItem> items = [];
    for (var language in languages) {
      items.add(
        DropdownMenuItem(
          value: language['id'],
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Image.asset(
                  language['image'],
                  width: 25,
                  height: 25,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(language['name'])
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
