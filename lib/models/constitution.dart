import 'package:flutter/foundation.dart';

class Constitutions {
  final int chapter;
  final int verse;
  final String title;
  final String text;
  int isBookmark;

  Constitutions(
      {@required this.chapter,
      @required this.verse,
      @required this.title,
      @required this.text,
      this.isBookmark});

  Map<String, dynamic> toMap() {
    return {
      'chapter': chapter,
      'verse': verse,
      'title': title,
      'text': text,
    };
  }
}
