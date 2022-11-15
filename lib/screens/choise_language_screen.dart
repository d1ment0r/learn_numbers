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
  String currentLanguage = 'tr';
  bool currentLanguageDownload = false;

  getSumTranslate() async {
    int _sumTranslate = await DBProvider.db.getSumTranslates();
    setState(() {
      currentLanguageDownload = _sumTranslate == 1000;
      developer.log('currentLanguageDownload - $currentLanguageDownload');
    });
    // developer.log('DB insert - $_sumTranslate ');
  }

  @override
  void initState() {
    super.initState();
    getSumTranslate();
  }

// Проверяем количество загруженных записей выбранного языка

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
                  developer.log('Start read from DB');
                  for (int id = 0; id < 100; id++) {
                    await DBProvider.db.getTranslateByID(id).then((result) {
                      globals.translateList.add(result);
                    });
                    if (id == 50) {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) =>
                                  const MainScreen(title: 'Turkish')),
                          (Route route) => false);
                    }
                  }
                } else {
                  for (int id = 0; id < 1000; id++) {
                    var english =
                        id > 0 ? NumberToWord().convert('en-in', id) : 'zero';
                    await translator
                        .translate(english, to: 'tr')
                        .then((result) {
                      // translateList
                      //     .add(Translate(id, result.toString().toLowerCase()));
                      DBProvider.db
                          .insertTranslate(Translate(id, result.toString()));

                      if (id < 50) {
                        setState(() {
                          _progress = id * 2;
                        });
                      }

                      // TODO: Загружаться должны первый десяток
                      // TODO: + первые 20 чисел из второго экрана
                      // TODO: + первые 20 чисел из третьего экрана
                      // после этого генериться событие DownloadComplted
                      // и меняется допустимый диапазон для рандномного выбора
                      if (id == 50) {
                        developer.log('id $id}');
                        // Navigator.pushNamed(
                        //   context,
                        //   '/main',
                        // );
                        // }
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) =>
                                    const MainScreen(title: 'Turkish')),
                            (Route route) => false);
                      }
                      if (id >= 99) {
                        developer.log('id $id}');
                      }
                    });
                  }
                }
                developer.log(
                    'Choise screen: end button choise language ${TimeOfDay.now()}');
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
