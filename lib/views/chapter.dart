import 'package:flutter/material.dart';

import '../controllers/data-manager.dart';
import '../models/constitution.dart';
import './widgets/font-picker-dialog.dart';
import './widgets/card-data.dart';

class Chapter extends StatefulWidget {
  @override
  _ChapterState createState() => _ChapterState();
}

class _ChapterState extends State<Chapter> {
  Future<List<Constitutions>> _chapter;
  String _title;
  int _chapterIndex;
  double textScalefactor = 1.0;
  bool _isFirstRun = true;

  @override
  void didChangeDependencies() {
    if (_isFirstRun) {
      Map<String, dynamic> routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
      if (routeArgs != null) {
        _title = routeArgs['title'];
        _chapterIndex = routeArgs['index'];
        _chapter = DataProvider.getData(_chapterIndex);
      }
      _isFirstRun = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.format_size),
            onPressed: () => showFontPickerDialog(context),
          )
        ],
      ),
      body: Container(
        child: FutureBuilder<List<Constitutions>>(
          future: _chapter,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            List<Constitutions> items = snapshot.data;
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                Constitutions item = items[index];
                return CardData(
                  item: item,
                );
              },
            );
          },
        ),
      ),
    );
  }

  void showFontPickerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) {
        return FontPickerDialog();
      },
    );
  }
}
