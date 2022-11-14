import 'dart:developer' as developer;

import 'package:learn_numbers/core/error/exception.dart';
import 'package:learn_numbers/data/db/database.dart';
import 'package:learn_numbers/models/translate.dart';

abstract class ITranslateLocalDataSource {
  Future<List<Translate>> getTranslatesFromDB();
  Future<void> translatesToDB(List<Translate> translates);
  Future<void> translateToDB(Translate translate);
}

class TranslateLocalDataSource implements ITranslateLocalDataSource {
  @override
  Future<List<Translate>> getTranslatesFromDB() async {
    final translatesList = await DBProvider.db.getTranslates();
    if (translatesList.isNotEmpty) {
      developer
          .log('DataSource: get ${translatesList.length} translate from DB');
      return Future.value(translatesList);
    } else {
      throw DBException();
    }
  }

  @override
  Future<List<Translate>> translatesToDB(List<Translate> translates) {
    for (var translate in translates) {
      DBProvider.db.insertTranslate(translate);
    }
    developer.log('DataSource: write ${translates.length} translates to DB');
    return Future.value(translates);
  }

  @override
  Future<Translate> translateToDB(Translate translate) {
    DBProvider.db.insertTranslate(translate);
    developer.log('DataSource: write translate to DB');
    return Future.value(translate);
  }
}
