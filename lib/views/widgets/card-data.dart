import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

import './card-text.dart';
import '../../models/constitution.dart';
import '../../providers/bookmark-manager.dart';
import '../../providers/font-manager.dart';

class CardData extends StatefulWidget {
  final Constitutions item;
  const CardData({Key key, @required this.item}) : super(key: key);

  @override
  _CardDataState createState() => _CardDataState();
}

class _CardDataState extends State<CardData> {
  Constitutions item;

  @override
  void initState() {
    item = widget.item;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<FontManager>(builder: (context, fontManager, child) {
        return Column(
          children: <Widget>[
            CardText(
              text: item.title,
              textStyle: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              iconButton: item.isBookmark == 0
                  ? IconButton(
                      iconSize: 24.0 + fontManager.fontScalefactor * 8,
                      icon: Icon(Icons.bookmark_border),
                      onPressed: () {
                        Provider.of<BookmarkManager>(context, listen: false)
                            .setBookmark(item.chapter, item.verse)
                            .then((_) => {
                                  setState(() {
                                    item.isBookmark = 1;
                                  })
                                });
                        Fluttertoast.cancel();
                        Fluttertoast.showToast(
                            msg: 'Added to Bookmarks',
                            backgroundColor: Colors.black);
                      },
                    )
                  : IconButton(
                      iconSize: 24.0 + fontManager.fontScalefactor * 8,
                      icon: Icon(Icons.bookmark),
                      onPressed: () {
                        Provider.of<BookmarkManager>(context, listen: false)
                            .removeBookmark(item.chapter, item.verse)
                            .then((_) => {
                                  setState(() {
                                    item.isBookmark = 0;
                                  })
                                });
                        Fluttertoast.cancel();
                        Fluttertoast.showToast(
                            msg: 'Removed from Bookmarks',
                            backgroundColor: Colors.black);
                      },
                    ),
            ),
            CardText(text: item.text),
            Divider(
              thickness: 3.0,
            ),
          ],
        );
      }),
    );
  }
}
