import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../controllers/data-manager.dart';
import '../models/constitution.dart';
import './widgets/card-data.dart';

class Search extends StatefulWidget {
  Search({Key key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController _textEditingController = TextEditingController();
  Future<List<Constitutions>> _list;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, kToolbarHeight * 2),
        child: SafeArea(
          child: Container(
            color: Theme.of(context).primaryColor,
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                Expanded(
                  child: Card(
                    color: Theme.of(context).accentColor,
                    elevation: 5.0,
                    margin: const EdgeInsets.all(8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: TextField(
                              controller: _textEditingController,
                              onSubmitted: (str) async {
                                if (str != '')
                                  setState(() {
                                    _list = DataProvider.searchData(str);
                                  });
                                else
                                  Fluttertoast.showToast(
                                    msg: 'Please enter a search keyword',
                                    backgroundColor: Colors.black,
                                  );
                              },
                              textInputAction: TextInputAction.search,
                              autofocus: true,
                              decoration: InputDecoration.collapsed(
                                hintText: 'Search Keyword',
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.search),
                            onPressed: () {
                              if (_textEditingController.text != '')
                                setState(() {
                                  _list = DataProvider.searchData(
                                      _textEditingController.text);
                                });
                              else
                                Fluttertoast.showToast(
                                  msg: 'Please enter a search keyword',
                                  backgroundColor: Colors.black,
                                );
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: FutureBuilder<List<Constitutions>>(
        future: _list,
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: Text('Type Keyword to Search'),
            );
          if (snapshot.data.length == 0)
            return Center(
              child: Text('No results found.'),
            );
          List<Constitutions> _items = snapshot.data;
          return ListView.builder(
            itemCount: _items.length,
            itemBuilder: (context, index) {
              Constitutions _item = _items[index];
              return CardData(item: _item);
            },
          );
        },
      ),
    );
  }
}

Widget tt(dynamic context) {
  return PreferredSize(
    preferredSize: const Size(double.infinity, kToolbarHeight),
    child: Builder(
      builder: (ctx) => Container(
        decoration: BoxDecoration(
            // color: Colors.tealAccent,
            color: Theme.of(context).accentColor,
            borderRadius: BorderRadius.circular(35)),
        child: ListTile(
            title: TextField(
              // controller: _text,
              onSubmitted: (str) async {
                if (str != '') {}
              },
              textInputAction: TextInputAction.search,
              autofocus: true,
              decoration: InputDecoration.collapsed(
                hintText: 'Search Keyword',
              ),
            ),
            trailing: IconButton(
                icon: Icon(Icons.search),
                onPressed: () async {
                  // if (_text.text != '') {
                  // }
                  FocusScope.of(context).unfocus();
                })),
      ),
    ),
  );
}
