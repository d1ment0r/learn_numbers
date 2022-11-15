import 'dart:developer' as developer;
import 'package:learn_numbers/models/globals.dart' as globals;
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:learn_numbers/db/database.dart';
import 'package:learn_numbers/models/translate.dart';
import 'package:learn_numbers/screens/main_screen.dart';
import 'package:number_to_words/number_to_words.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:translator/translator.dart';

class ChoiseLanguageScreen extends StatefulWidget {
  const ChoiseLanguageScreen({super.key});
  @override
  State<ChoiseLanguageScreen> createState() => _ChoiseLanguageScreenState();
}

class _ChoiseLanguageScreenState extends State<ChoiseLanguageScreen> {
  int _progress = 0;
  final int _sumTranslate = 3;
  String currentLanguage = 'ru';
  bool currentLanguageDownload = false;

  getSumTranslate() async {
    int sumTranslate = await DBProvider.db.getSumTranslates();
    setState(() {
      // Проверяем количество загруженных записей выбранного языка
      currentLanguageDownload = sumTranslate == 1000;
      developer.log(
          'Choise screen[30]: currentLanguageDownload - $currentLanguageDownload');
    });
  }

  @override
  void initState() {
    super.initState();
    getSumTranslate();
  }

  @override
  Widget build(BuildContext context) {
    final translator = GoogleTranslator();
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          const SizedBox(
            height: 300,
            child: Center(
                child: Text(
              'Choise language',
              textAlign: TextAlign.center,
            )),
          ),
          GestureDetector(
              onTap: () async {
                // Если текущий язык загружен считываем его в глобальный лист
                if (currentLanguageDownload) {
                  developer.log('CLS begin download from database');
                  //
                  // Первый и второй экран от 0 до 9 и от 10 до 29
                  //
                  for (int id = 0; id < 30; id++) {
                    await DBProvider.db.getTranslateByID(id).then(
                      (translate) {
                        globals.numericMap
                            .putIfAbsent(id, () => translate.result);
                        // developer.log('CLS - 1 step id - $id');
                      },
                    );
                  }
                  //
                  // Третий экран от 100 до 999
                  //
                  for (int id = 100; id < 1000; id++) {
                    await DBProvider.db.getTranslateByID(id).then(
                      (translate) {
                        globals.numericMap
                            .putIfAbsent(id, () => translate.result);
                        // developer.log('CLS - 2 step id - $id');
                        // Если частично агружены открываем первый экран
                        //
                        if (id == 121) {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const MainScreen(title: 'Turkish')),
                              (Route route) => false);
                        }
                      },
                    );
                  }
                  //
                  // Заполняем недостающие элементы
                  //
                  for (int id = 30; id < 100; id++) {
                    await DBProvider.db.getTranslateByID(id).then(
                      (translate) {
                        globals.numericMap
                            .putIfAbsent(id, () => translate.result);
                        // developer.log('CLS - 3 step id - $id');
                        if (id == 99) {
                          globals.allNumericAccess = true;
                          // developer.log('CLS end download from database');
                        }
                      },
                    );
                  }
                } else {
                  //
                  // Первый и второй экран от 0 до 9 и от 10 до 29
                  //
                  for (int id = 0; id < 30; id++) {
                    //
                    // Этап первый - число в английский
                    var english =
                        id > 0 ? NumberToWord().convert('en-in', id) : 'zero';
                    //
                    // Этап второй - английский в выбранный язык
                    await translator
                        .translate(english, to: currentLanguage)
                        .then((result) {
                      //
                      // Этап третий - пишем в базу добавляя к глобальному списку
                      String trueResult = result.toString().toLowerCase();
                      DBProvider.db.insertTranslate(Translate(id, trueResult));
                      globals.numericMap.putIfAbsent(id, () => trueResult);
                      developer.log('CLS - 1 step id - $id');
                      //
                      // Показываем прогресс бар
                      if (id < 51) {
                        setState(() {
                          _progress = id * 2;
                        });
                      }
                    });
                  }
                  //
                  // Третий экран от 100 до 999
                  //
                  for (int id = 100; id < 1000; id++) {
                    //
                    // Этап первый - число в английский
                    var english =
                        id > 0 ? NumberToWord().convert('en-in', id) : 'zero';
                    //
                    // Этап второй - английский в выбранный язык
                    await translator
                        .translate(english, to: currentLanguage)
                        .then(
                      (result) {
                        //
                        // Этап третий - пишем в базу добавляя к глобальному списку
                        String trueResult = result.toString().toLowerCase();
                        DBProvider.db
                            .insertTranslate(Translate(id, trueResult));
                        globals.numericMap.putIfAbsent(id, () => trueResult);
                        developer.log('CLS - 2 step id - $id');
                        //
                        // Показываем прогресс бар
                        if (id - 70 < 51) {
                          setState(() {
                            _progress = (id - 70) * 2;
                          });
                        }
                        //
                        // Если частично агружены открываем первый экран
                        //
                        if (id == 121) {
                          developer.log('id $id}');
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const MainScreen(title: 'Turkish')),
                              (Route route) => false);
                        }
                      },
                    );
                  }
                  //
                  // Заполняем недостающие элементы
                  //
                  for (int id = 30; id < 100; id++) {
                    //
                    // Этап первый - число в английский
                    //
                    var english =
                        id > 0 ? NumberToWord().convert('en-in', id) : 'zero';
                    //
                    // Этап второй - английский в выбранный язык
                    //
                    await translator
                        .translate(english, to: 'tr')
                        .then((result) {
                      //
                      // Этап третий - пишем в базу добавляя к глобальному списку
                      //
                      String trueResult = result.toString().toLowerCase();
                      DBProvider.db.insertTranslate(Translate(id, trueResult));
                      globals.numericMap.putIfAbsent(id, () => trueResult);
                      if (id == 99) {
                        globals.allNumericAccess = true;
                        // developer.log('CLS end save to database');
                      }
                      // developer.log('CLS - 3 step id - $id');
                    });
                  }
                }
              },
              child: Container(
                height: 50.0,
                width: 50.0,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(25),
                  image: DecorationImage(
                    image: Svg(
                        _sumTranslate < 1001
                            ? 'assets/images/download.svg'
                            : 'assets/images/arrow.svg',
                        size: const Size(25.0, 25.0),
                        color:
                            _sumTranslate < 1001 ? Colors.black : Colors.teal),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade500,
                      spreadRadius: 1,
                      blurRadius: 8,
                      offset: const Offset(4, 4),
                    ),
                    const BoxShadow(
                      color: Colors.white,
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: Offset(-4, -4),
                    ),
                  ],
                ),
              )
              // },
              // ),
              ),
          const SizedBox(
            height: 50,
          ),
          CircularPercentIndicator(
            radius: 60.0,
            lineWidth: 15.0,
            percent: _progress / 100,
            animation: false,
            animationDuration: 1500,
            center: Text(
              '$_progress %',
              style: const TextStyle(fontSize: 20.0),
            ),
            progressColor: Colors.amber[900],
          ),
        ],
      ),
    );
  }
}
