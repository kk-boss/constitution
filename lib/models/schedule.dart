class Schedule {
  final int book = 2;
  final int chapter;
  final int verse;
  final String title;
  final String subtitle;
  final String text;
  int isBookmark;

  Schedule(
      {this.chapter,
      this.title,
      this.verse,
      this.subtitle,
      this.text,
      this.isBookmark});
}
