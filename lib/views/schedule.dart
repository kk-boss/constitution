import 'package:flutter/material.dart';

import '../models/schedule.dart';
import '../controllers/data-manager.dart';

import './widgets/card-text.dart';
import './widgets/font-picker-dialog.dart';

class ScheduleView extends StatefulWidget {
  ScheduleView({Key key}) : super(key: key);

  @override
  _ScheduleViewState createState() => _ScheduleViewState();
}

class _ScheduleViewState extends State<ScheduleView> {
  Future<List<Schedule>> _schedule;
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
        _schedule = DataProvider.getScheduleData(_chapterIndex);
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
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) {
                    return FontPickerDialog();
                  },
                );
              })
        ],
      ),
      body: Container(
        child: FutureBuilder<List<Schedule>>(
          future: _schedule,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            List<Schedule> items = snapshot.data;
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                Schedule item = items[index];
                return Column(
                  children: <Widget>[
                    CardText(
                      text: item.subtitle,
                    ),
                    if (_chapterIndex == 1)
                      buildCardImage('assets/nepal_flag.png'),
                    if (_chapterIndex == 3) buildCardImage('assets/emblem.png'),
                    CardText(text: item.text),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }

  Container buildCardImage(String image) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(
        10.0,
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Image.asset(image),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
