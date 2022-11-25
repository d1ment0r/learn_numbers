import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:learn_numbers/db/database.dart';
import 'package:learn_numbers/models/language.dart';
import 'package:number_to_words/number_to_words.dart';
import 'package:path_provider/path_provider.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:learn_numbers/models/globals.dart' as globals;
import 'package:text_to_speech/text_to_speech.dart';
import 'package:translator/translator.dart';
import 'package:url_launcher/url_launcher.dart';

import 'main_screen.dart';

TextToSpeech tts = TextToSpeech();

class ChoiseLanguageScreen extends StatefulWidget {
  const ChoiseLanguageScreen({super.key, required this.firstInit});
  final bool firstInit;

  @override
  State<ChoiseLanguageScreen> createState() => _ChoiseLanguageScreenState();
}

class _ChoiseLanguageScreenState extends State<ChoiseLanguageScreen> {
  // Special for me
  double progress = 0;
  bool _isElevated = false;
  final _iAmCreater = true;
  final _createJsonFile = true;
  bool _pressButtonCreater = false;
  final Uri toMySite = Uri(scheme: 'https', host: 'www.dmitrii.online');

  // Map embeded languages
  Language _currentLanguage = Language(
    id: 0,
    name: '',
    image: '',
    languageCode: '',
    voice: '',
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
    languageCode: 'en',
    voice: 'en-US',
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
        // это запуск приложения
        if (widget.firstInit) {
          // ignore: use_build_context_synchronously
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (context) => MainScreen(
                        title: _currentLanguage.name,
                      )),
              (Route route) => false);
          await Future.delayed(const Duration(seconds: 1));
          FlutterNativeSplash.remove();
          // это переход из запущенного приложения
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
            choiseLanguageWidget(),
            rowVolumeWidget(),
            rowRateWidget(),
            rowPitchWidget(),
            Expanded(
              child: Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      !_iAmCreater
                          ? GestureDetector(
                              onTap: () async {
                                await DBProvider.db
                                    .updateSettins(_selectedLanguage);
                                setState(() {
                                  _languageChange =
                                      _currentLanguage != _selectedLanguage;
                                  _isElevated = !_isElevated;
                                });
                                await Future.delayed(
                                    const Duration(milliseconds: 200));
                                initializationApp();
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
                                  SvgPicture.asset('assets/icon/ok_bold.svg',
                                      width: 40,
                                      height: 40,
                                      color: Colors.green),
                                ],
                              ),
                            )
                          : GestureDetector(
                              onTap: () async {
                                setState(() {
                                  _pressButtonCreater = !_pressButtonCreater;
                                });
                                if (_createJsonFile) {
                                  createJsonFile();
                                } else {
                                  createTxtFile();
                                }
                              },
                              // Кнопка, только для меня
                              child: Stack(
                                alignment: AlignmentDirectional.center,
                                children: [
                                  if (progress == 0)
                                    AnimatedContainer(
                                      duration:
                                          const Duration(microseconds: 200),
                                      height: 100.0,
                                      width: 100.0,
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
                                        boxShadow: !_pressButtonCreater
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
                                  if (progress == 0)
                                    _createJsonFile
                                        ? SvgPicture.asset(
                                            'assets/icon/json.svg',
                                            width: 60,
                                            height: 60,
                                          )
                                        : SvgPicture.asset(
                                            'assets/icon/txt.svg',
                                            width: 60,
                                            height: 60,
                                          ),
                                  if (progress > 0)
                                    CircularPercentIndicator(
                                      radius: 100.0,
                                      lineWidth: 18.0,
                                      percent: progress,
                                      backgroundColor: Colors.grey.shade300,
                                      animation: false,
                                      animationDuration: 500,
                                      center: Text(
                                        '${(progress * 100) ~/ 1} %',
                                        style: const TextStyle(fontSize: 25.0),
                                      ),
                                      progressColor: const Color(0xFF3399CC),
                                    ),
                                ],
                              ),
                            ),
                    ],
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 25.0),
              child: GestureDetector(
                onTap: () {
                  _launchUrl();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.copyright,
                      size: 14.0,
                      color: Colors.blue.shade800,
                    ),
                    Text(
                      '  dmitrii.online',
                      style: TextStyle(
                          fontSize: 16.0, color: Colors.blue.shade800),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container choiseLanguageWidget() {
    return Container(
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

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFileJson async {
    final path = await _localPath;
    developer.log('$path/${_selectedLanguage.languageCode}.json');
    return File('$path/json/${_selectedLanguage.languageCode}.json');
  }

  Future<File> get _localFileTxt async {
    final path = await _localPath;
    developer.log('$path/${_selectedLanguage.languageCode}.txt');
    return File('$path/${_selectedLanguage.languageCode}.txt');
  }

  Future<void> createTxtFile() async {
    final filePath = await _localFileTxt;
    String string = '';
    var jsonText = await rootBundle
        .loadString('assets/json/${_selectedLanguage.languageCode}.json');
    Map<String, dynamic> data = json.decode(jsonText);
    // очищаем языковую карту, на случай если из настроек сменили язык
    globals.sortingMap.clear();
    // заполняем карту переводом
    data.forEach((key, value) {
      globals.sortingMap.putIfAbsent(int.parse(key), () => value.toString());
    });
    for (int i = 0; i < 1000; i++) {
      string =
          '$string${i.toString().padLeft(3, ' ')} ${globals.sortingMap[i].toString()}\n';
      setState(() {
        progress = i / 1000;
      });
    }

    filePath.writeAsString(string);
    setState(() {
      progress = 0;
      _pressButtonCreater = false;
    });
  }

  Future<void> createJsonFile() async {
    final translator = GoogleTranslator();
    // HashMap numericJSON = HashMap<String, dynamic>();
    SplayTreeMap sortingMap = SplayTreeMap<String, String>();
    globals.sortingMap.clear();
    for (int id = 0; id < 1000; id++) {
      // Этап первый - число в английский
      String english = id > 0 ? NumberToWord().convert('en-in', id) : 'zero';
      // Этап второй - английский в выбранный язык
      String languageCode = _selectedLanguage.languageCode.substring(0, 2);
      languageCode = _selectedLanguage.languageCode;
      await translator.translate(english, to: languageCode).then((result) {
        String trueResult = result.toString().toLowerCase();
        // numericJSON.putIfAbsent(id.toString(), () => trueResult);
        sortingMap.putIfAbsent(id.toString(), () => trueResult);
        // Показываем прогресс бар
        // if (id % 100 == 0) {
        setState(() {
          progress = id / 1000;
        });
        // }
      });
    }
    setState(() {
      progress = 0;
      _pressButtonCreater = false;
    });
    final filePath = await _localFileJson;

    filePath.writeAsString(jsonEncode(sortingMap));
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(toMySite)) {
      throw 'Could not launch';
    }
  }
}
