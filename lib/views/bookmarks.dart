import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../providers/bookmark-manager.dart';
import '../models/constitution.dart';
import '../views/widgets/card-text.dart';

class Bookmarks extends StatelessWidget {
  const Bookmarks({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bookmarks'),
      ),
      body: Consumer<BookmarkManager>(
        builder: (context, bookmarkManager, child) {
          List<Constitutions> bookmarks = bookmarkManager.bookmarks;
          if (bookmarks.length == 0)
            return Center(
              child: Text('No Bookmarks'),
            );
          return buildBookmarks(bookmarks, bookmarkManager);
        },
      ),
    );
  }

  ListView buildBookmarks(
      List<dynamic> bookmarks, BookmarkManager bookmarkManager) {
    return ListView.builder(
      itemCount: bookmarks.length,
      itemBuilder: (context, index) {
        dynamic item = bookmarks[index];
        return Column(
          children: <Widget>[
            CardText(
              text: item.title,
              textStyle: TextStyle(fontWeight: FontWeight.bold),
              iconButton: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  bookmarkManager.removeBookmark(item.chapter, item.verse);
                  Fluttertoast.cancel();
                  Fluttertoast.showToast(
                      msg: 'Bookmark deleted', backgroundColor: Colors.black);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: CardText(
                text: item.text,
              ),
            ),
            Divider(
              thickness: 3.0,
            ),
          ],
        );
      },
    );
  }
}
