import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:developer' as console;
import 'dart:io';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:learn_numbers/core/theme_service.dart';
import 'package:learn_numbers/db/database.dart';
import 'package:learn_numbers/models/language.dart';
import 'package:learn_numbers/themes/theme.dart';
import 'package:number_to_words/number_to_words.dart';
import 'package:path_provider/path_provider.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:learn_numbers/models/globals.dart' as globals;
import 'package:text_to_speech/text_to_speech.dart';
import 'package:translator/translator.dart';
import 'package:url_launcher/url_launcher.dart';

import 'app_screen.dart';

TextToSpeech tts = TextToSpeech();

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key, required this.firstInit});
  final bool firstInit;

  @override
  State<SettingsScreen> createState() => _CSettingsScreenState();
}

class _CSettingsScreenState extends State<SettingsScreen> {
  // Special for me
  double progress = 0;
  bool _isElevated = false;
  final _iAmCreater = false;
  final _createJsonFile = false;
  bool _pressButtonCreater = false;
  final Uri toMySite = Uri(scheme: 'https', host: 'www.dmitrii.online');

// Settings Speech & Language
  String? _voice;
  String? _displayLanguage;

  // Map embeded languages
  Language _currentLanguage = globals.currentLanguage;
  Language _selectedLanguage = globals.currentLanguage;

  List<DropdownMenuItem> dropdownMenuItems = [];
  List<Language> languages = [];

  bool _languageChange = false;
  int tempCurrentPage = globals.currentPage;

  @override
  void initState() {
    languages = Language.getAll();
    dropdownMenuItems = buildDropdownMenuItems();
    if (widget.firstInit) {
      initializationApp();
    } else {
      _currentLanguage = (globals.currentLanguage);
      _selectedLanguage = (globals.currentLanguage);
      setVoice(globals.currentLanguage.voiceCode, false);
      setDisplayLanguageByCode(_currentLanguage.voiceCode);
    }
    super.initState();
  }

  // Инициализация приложения
  void initializationApp() async {
    // Read settings from db
    _currentLanguage = await DBProvider.db.getSettings();
    // Если в базе есть запись с выбранным языком, тогда возвращается записанный
    // если язык не записан, то возвращается объект с translateCode = ''
    if (_currentLanguage.translateCode != '') {
      console.log(
          '\u001b[1;33mSettings screen:\u001b[1;34m initializationApp \u001b[0mlanguage is \u001b[1;32m${_currentLanguage.translateCode}');
      globals.currentLanguage = _currentLanguage;
      // Set speech voice
      setVoice(_currentLanguage.voiceCode, true);
      // считываем файл с переводом
      var jsonText = await rootBundle
          .loadString('assets/json/${_currentLanguage.translateCode}.json');
      Map<String, dynamic> data = json.decode(jsonText);
      // очищаем языковую карту, на случай если из настроек сменили язык
      globals.sortingMap.clear();
      // заполняем карту переводом
      data.forEach((key, value) {
        globals.sortingMap.putIfAbsent(int.parse(key), () => value.toString());
      });
      // если языковая карта заполнена, то есть два варианта
      if (globals.sortingMap.isNotEmpty) {
        // Переходим на главный экран, потому что это запуск приложения
        // при этом удаляем из пула этот, что бы кнопкой назад не попасть на него
        if (widget.firstInit) {
          // ignore: use_build_context_synchronously
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (context) => AppScreen(
                        title: _currentLanguage.name,
                      )),
              (Route route) => false);
          await Future.delayed(const Duration(seconds: 1));
          FlutterNativeSplash.remove();
          // Возвращаемся туда, откуда был открыт экран настроек
          // потосму что это переход из запущенного приложения
        } else {
          if (_languageChange) {
            globals.currentPage = 1;
            // ignore: use_build_context_synchronously
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => AppScreen(
                          title: _currentLanguage.name,
                        )),
                (Route route) => false);
          } else {
            // globals.currentPage = tempCurrentPage;
            // ignore: use_build_context_synchronously
            Navigator.pop(context);
          }
        }
      } else {
        // TODO Ошибка при загрузке файла с переводом, добавить обработчик
      }
      // Записей в базе нет, устанавливаем по умолчанию Английский
    } else {
      _currentLanguage = _selectedLanguage;
      console.log(
          '\u001b[1;33mSettings screen: \u001b[1;34minitializationApp \u001b[0mlanguage \u001b[1;32mset default');
      // Set speech voice
      setVoice(_currentLanguage.voiceCode, true);
      setDisplayLanguageByCode(_currentLanguage.voiceCode);
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
    bool isDark = ThemeModelInheritedNotifier.of(context).theme.brightness ==
        Brightness.dark;
    return ThemeSwitchingArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
          actions: [
            ThemeSwitcher(builder: (context) {
              return IconButton(
                onPressed: () async {
                  var themeName = ThemeModelInheritedNotifier.of(context)
                              .theme
                              .brightness ==
                          Brightness.light
                      ? 'dark'
                      : 'light';
                  var service = await ThemeService.instance
                    ..save(themeName);
                  var theme = service.getByName(themeName);
                  // ignore: use_build_context_synchronously
                  ThemeSwitcher.of(context).changeTheme(theme: theme);
                },
                icon:
                    ThemeModelInheritedNotifier.of(context).theme.brightness ==
                            Brightness.light
                        ? const Icon(
                            Icons.sunny,
                            size: 25,
                          )
                        : const Icon(
                            Icons.brightness_3,
                            size: 25,
                          ),
              );
            })
          ],
        ),
        // backgroundColor: Theme.of(context).primaryColor,
        body: Padding(
          padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0),
          child: Column(
            children: [
              choiseLanguageWidget(),
              rowVoiceAndLanguage(),
              rowVolumeWidget(),
              rowRateWidget(),
              rowPitchWidget(),
              // Кнопки
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
                                      duration:
                                          const Duration(microseconds: 200),
                                      height: 60.0,
                                      width: 60.0,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            isDark
                                                ? darkAppColors
                                                : lithAppColors,
                                            isDark
                                                ? darkAppColors
                                                : lithAppColors,
                                          ],
                                        ),
                                        boxShadow: !_isElevated
                                            ? [
                                                BoxShadow(
                                                  color: isDark
                                                      ? darkAppShadowBottom
                                                      : lithAppShadowBottom,
                                                  spreadRadius: 1,
                                                  blurRadius: 5,
                                                  offset: const Offset(4, 4),
                                                ),
                                                BoxShadow(
                                                  color: isDark
                                                      ? darkAppShadowTop
                                                      : lithAppShadowTop,
                                                  spreadRadius: 1,
                                                  blurRadius: 5,
                                                  offset: const Offset(-4, -4),
                                                ),
                                              ]
                                            : [
                                                BoxShadow(
                                                  color: isDark
                                                      ? darkAppShadowTop
                                                      : lithAppShadowTop,
                                                  offset: const Offset(-4, -4),
                                                  blurRadius: 5,
                                                  spreadRadius: 1,
                                                  inset: true,
                                                ),
                                                BoxShadow(
                                                  color: isDark
                                                      ? darkAppShadowBottom
                                                      : lithAppShadowBottom,
                                                  offset: const Offset(4, 4),
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
                            // Кнопка, только для меня
                            : buttonOnlyForCreater(),
                      ],
                    )),
              ),
              const Divider(thickness: 1.0),
              Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 25.0),
                child: GestureDetector(
                  onTap: () {
                    _launchUrl();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.copyright,
                        size: 14.0,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'dmitrii.online',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 2.0,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding rowVoiceAndLanguage() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Text('Voice: '),
              Text(
                _voice != null ? 'found' : 'not found',
                style: TextStyle(
                    color: _voice != null ? Colors.green : Colors.red,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text('Language: '),
              Text(
                _displayLanguage ?? _selectedLanguage.name,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ],
      ),
    );
  }

  GestureDetector buttonOnlyForCreater() {
    bool isDark = ThemeModelInheritedNotifier.of(context).theme.brightness ==
        Brightness.dark;
    return GestureDetector(
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
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          if (progress == 0)
            AnimatedContainer(
              duration: const Duration(microseconds: 200),
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
                        BoxShadow(
                          color: isDark
                              ? darkAppShadowBottom
                              : lithAppShadowBottom,
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(4, 4),
                        ),
                        BoxShadow(
                          color: isDark ? darkAppShadowTop : lithAppShadowTop,
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(-4, -4),
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
                        BoxShadow(
                          color: isDark ? darkAppShadowTop : lithAppShadowTop,
                          offset: const Offset(4, 4),
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
    );
  }

  Container choiseLanguageWidget() {
    bool isDark = ThemeModelInheritedNotifier.of(context).theme.brightness ==
        Brightness.dark;
    return Container(
      width: 600,
      margin: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              isDark ? darkAppColors : lithAppColors,
              isDark ? darkAppColors : lithAppColors,
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: isDark ? darkAppShadowBottom : lithAppShadowBottom,
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(5, 5),
            ),
            BoxShadow(
              color: isDark ? darkAppShadowTop : lithAppShadowTop,
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(-4, -4),
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

  onChangeDropdownItem(int id) async {
    setVoice(languages[id].voiceCode, false);
    setDisplayLanguageByCode(languages[id].voiceCode);
    setState(() {
      _selectedLanguage = languages[id];
      _selectedLanguage.reversMap = _currentLanguage.reversMap;
      _selectedLanguage.soundOn = _currentLanguage.soundOn;
      _selectedLanguage.volume = _currentLanguage.volume;
      _selectedLanguage.rate = _currentLanguage.rate;
      _selectedLanguage.pitch = _currentLanguage.pitch;
    });
  }

  Future<void> setVoice(voiceCode, global) async {
    // final String? defaultLangCode = await tts.getDefaultLanguage();
    _voice = null;
    if (voiceCode != null && voiceCode != '') {
      List<String> translateCodes = <String>[];
      // populate lang code (i.e. en-US)
      translateCodes = await tts.getLanguages();
      if (translateCodes.contains(voiceCode)) {
        _voice = voiceCode;
      }
    }
    if (global) {
      globals.voice = _voice;
    }
    setState(() {});
    console.log(
        '\u001b[1;33mSettings screen: \u001b[1;34msetVoice \u001b[0mvoice is \u001b[1;32m$_voice');
  }

  Future<void> setDisplayLanguageByCode(code) async {
    if (code != null && code != '') {
      _displayLanguage = await tts.getDisplayLanguageByCode(code);
    }
    setState(() {});
    console.log(
        '\u001b[1;33mSettings screen: \u001b[1;34mgetDisplayLanguageByCode \u001b[0mdisplay language is \u001b[1;32m$_displayLanguage');
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
    console.log('$path/${_selectedLanguage.translateCode}.json');
    return File('$path/json/${_selectedLanguage.translateCode}.json');
  }

  Future<File> get _localFileTxt async {
    final path = await _localPath;
    console.log('$path/${_selectedLanguage.translateCode}.txt');
    return File('$path/${_selectedLanguage.translateCode}.txt');
  }

  Future<void> createTxtFile() async {
    final filePath = await _localFileTxt;
    String string = '';
    int maxLength = 0;
    String maxLengthString = '';
    var jsonText = await rootBundle
        .loadString('assets/json/${_selectedLanguage.translateCode}.json');
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
      if (globals.sortingMap[i].toString().length > maxLength) {
        maxLength = globals.sortingMap[i].toString().length;
        maxLengthString = i.toString();
      }
      setState(() {
        progress = i / 1000;
      });
    }

    console.log(
        '${_selectedLanguage.name} max lenght $maxLength numer $maxLengthString');
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
      String translateCode = _selectedLanguage.translateCode;
      await translator.translate(english, to: translateCode).then((result) {
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
