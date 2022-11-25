import 'dart:developer' as developer;
import 'dart:io';

import 'package:learn_numbers/models/language.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();
  static late Database _database;

  String titleTable = 'current';
  int version = 2;

  Future<Database> get database async {
    _database = await _initDB();
    return _database;
  }

  Future<Database> _initDB() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = '${dir.path}/language.db';
    return await openDatabase(path, version: version, onCreate: _createDB);
  }

  void _createDB(Database db, int version) async {
    await db.execute(
      'CREATE TABLE $titleTable(id INTEGER PRIMARY KEY, name TEXT, image TEXT, languageCode TEXT, voice TEXT, reversMap INTEGER, soundOn INTEGER, volume REAL, rate REAL, pitch REAL)',
    );
  }

  // READ settings
  Future<Language> getSettings() async {
    Database db = await database;
    final List<Map<String, dynamic>> languagesMapList =
        await db.query(titleTable);
    final List<Language> languagesList = [];
    for (var languageMap in languagesMapList) {
      languagesList.add(Language.fromMap(languageMap));
    }
    developer
        .log('DB: (getSettings) read settings list ${languagesList.length}');
    if (languagesList.isEmpty) {
      return Language(
          id: 0,
          name: '',
          image: '',
          languageCode: '',
          voice: '',
          reversMap: true,
          soundOn: false,
          volume: 0,
          rate: 0,
          pitch: 0);
    } else {
      return languagesList.first;
    }
  }

  // UPDATE settings
  Future<Language> updateSettins(Language language) async {
    Database db = await database;
    final int resultDelete = await db.delete(titleTable);
    final int resultInsert = await db.insert(titleTable, language.toMap());
    developer
        .log('DB: (updateSettins) delete: $resultDelete insert: $resultInsert');
    return language;
  }
}
