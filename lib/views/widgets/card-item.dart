import 'package:flutter/material.dart';

import '../../controllers/ad-manager.dart';

enum CardType { Chapter, Schedule }

class CardItem extends StatelessWidget {
  final int index;
  final String leading;
  final String title;
  final CardType cardType;
  const CardItem(
      {@required this.index,
      @required this.leading,
      @required this.title,
      @required this.cardType});

  @override
  Widget build(BuildContext context) {
    final AdManager _adManager = AdManager();
    return InkWell(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(
          8.0,
        ),
        child: Card(
          color: cardType == CardType.Chapter
              ? Theme.of(context).accentColor
              : Theme.of(context).primaryColorDark,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: Text(leading),
              title: Text(title),
            ),
          ),
        ),
      ),
      onTap: () {
        _adManager.cardPressed++;
        if (cardType == CardType.Chapter)
          Navigator.of(context).pushNamed('/chapter', arguments: {
            'title': title,
            'index': index,
          });
        else
          Navigator.of(context).pushNamed('/schedule', arguments: {
            'title': title,
            'index': index + 1,
          });
      },
    );
  }
}
