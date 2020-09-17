import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

import '../models/constitution.dart';
import '../controllers/database-helper.dart';

class BookmarkManager with ChangeNotifier {
  List<Constitutions> _bookmarks;

  BookmarkManager() {
    _loadBookmark();
  }

  void _loadBookmark() async {
    bool dbExists = await databaseExists(
      await DatabaseHelper.getDatabasePath(),
    );
    if (!dbExists) return;
    DatabaseHelper.initDatabase().then((Database db) {
      db.query(DatabaseHelper.CHAPTER_TABLE_NAME,
          where: 'isBookmark=?',
          whereArgs: [1]).then((List<Map<String, dynamic>> maps) {
        _bookmarks = List.generate(maps.length, (i) {
          return Constitutions(
            chapter: maps[i]['chapter'],
            verse: maps[i]['verse'],
            title: maps[i]['title'],
            text: maps[i]['text'],
          );
        });
        notifyListeners();
      });
    }).catchError((err) {
      _bookmarks = [];
    });
  }

  List<Constitutions> get bookmarks {
    if (_bookmarks == null) {
      _bookmarks = [];
    }
    return _bookmarks;
  }

  Future<void> setBookmark(int chapter, int verse) async {
    final Database db = await DatabaseHelper.initDatabase();
    await db.update(DatabaseHelper.CHAPTER_TABLE_NAME, {'isBookmark': 1},
        where: 'chapter=? and verse=?', whereArgs: [chapter, verse]);
    notifyListeners();
    _loadBookmark();
  }

  Future<void> removeBookmark(int chapter, int verse) async {
    final Database db = await DatabaseHelper.initDatabase();
    await db.update(DatabaseHelper.CHAPTER_TABLE_NAME, {'isBookmark': 0},
        where: 'chapter=? and verse=?', whereArgs: [chapter, verse]);
    notifyListeners();
    _loadBookmark();
  }
}
