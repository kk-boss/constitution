import 'package:sqflite/sqflite.dart';

import '../models/constitution.dart';
import '../models/schedule.dart';
import './database-helper.dart';

class DataProvider {
  static Future<List<Constitutions>> getData(int chapter) async {
    final Database db = await DatabaseHelper.initDatabase();
    final List<Map<String, dynamic>> maps = await db.query(
        DatabaseHelper.CHAPTER_TABLE_NAME,
        where: 'chapter=?',
        whereArgs: [chapter]);
    return List.generate(maps.length, (i) {
      return Constitutions(
        chapter: maps[i]['chapter'],
        verse: maps[i]['verse'],
        title: maps[i]['title'],
        text: maps[i]['text'],
        isBookmark: maps[i]['isBookmark'],
      );
    });
  }

  static Future<List<Schedule>> getScheduleData(int chapter) async {
    final Database db = await DatabaseHelper.initDatabase();
    final List<Map<String, dynamic>> maps = await db.query(
        DatabaseHelper.SCHEDULE_TABLE_NAME,
        where: 'chapter=?',
        whereArgs: [chapter]);
    return List.generate(maps.length, (i) {
      return Schedule(
        chapter: maps[i]['chapter'],
        title: maps[i]['title'],
        verse: maps[i]['verse'],
        subtitle: maps[i]['subtitle'],
        text: maps[i]['text'],
        isBookmark: maps[i]['isBookmark'],
      );
    });
  }

  static Future<List<Constitutions>> searchData(String text) async {
    final Database db = await DatabaseHelper.initDatabase();
    final List<Map<String, dynamic>> maps = await db.rawQuery(
        'SELECT * FROM ${DatabaseHelper.CHAPTER_TABLE_NAME} WHERE text LIKE ?',
        ['%$text%']);
    return List.generate(maps.length, (i) {
      return Constitutions(
        chapter: maps[i]['chapter'],
        verse: maps[i]['verse'],
        title: maps[i]['title'],
        text: maps[i]['text'],
        isBookmark: maps[i]['isBookmark'],
      );
    });
  }
}
