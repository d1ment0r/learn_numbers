import 'dart:developer' as developer;
import 'dart:io';

import 'package:learn_numbers/models/translate.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();
  static late Database _database;

  String currentLanguageTable = 'tr';

  Future<Database> get database async {
    _database = await _initDB();
    return _database;
  }

  Future<Database> _initDB() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = '${dir.path}/translate.db';
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  void _createDB(Database db, int version) async {
    await db.execute(
      'CREATE TABLE $currentLanguageTable(id INTEGER PRIMARY KEY, result TEXT)',
    );
  }

  // READ ALL Translate
  Future<List<Translate>> getTranslates() async {
    Database db = await database;
    final List<Map<String, dynamic>> translatesMapList =
        await db.query(currentLanguageTable);
    final List<Translate> translatesList = [];
    for (var translateMap in translatesMapList) {
      translatesList.add(Translate.fromMap(translateMap));
    }
    developer.log('Read translate list ${translatesList.length}');
    return translatesList;
  }

  // INSERT ONE translate
  Future<Translate> insertTranslate(Translate translate) async {
    Database db = await database;
    final List<Map<String, dynamic>> translatesMapList = await db.query(
      currentLanguageTable,
      where: 'id = ?',
      whereArgs: [translate.id],
    );
    if (translatesMapList.isEmpty) {
      // translator.translate(translate.result, to: 'tr').then((result) async {

      //           translate.result = result.toString().toLowerCase();
      translate.id = await db.insert(currentLanguageTable, translate.toMap());
      developer.log('DB insert - translate '
          '${translate.id}'
          ' not found, translate save');
    } else {
      developer.log('DB insert - translate '
          '${translate.id}'
          ' found, translate update');
      updateTranslate(translate);
    }
    return translate;
  }

  // UPDATE ONE
  Future<int> updateTranslate(Translate translate) async {
    Database db = await database;
    return await db.update(
      currentLanguageTable,
      translate.toMap(),
      where: 'id = ?',
      whereArgs: [translate.id],
    );
  }

  // DELETE ONE
  Future<int> deleteTranslate(int? id) async {
    Database db = await database;
    return await db.delete(
      currentLanguageTable,
      where: '$id = ?',
      whereArgs: [id],
    );
  }
}
