import 'package:ConstitutionOfNepal/controllers/ad-manager.dart';
import 'package:flutter/material.dart';

import './widgets/card-item.dart';
import './widgets/side-drawer.dart';

import '../constants/title.dart';
import '../controllers/database-helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<bool> _copyAudio;
  @override
  void initState() {
    _copyAudio = DatabaseHelper.copyAudioData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AdManager _adManager = AdManager();
    return Scaffold(
      drawer: SideDrawer(),
      body: FutureBuilder<bool>(
        future: _copyAudio,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor: Theme.of(context).primaryColor,
                floating: false,
                pinned: true,
                expandedHeight: 200,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(
                    'नेपालको संविधान',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  background: Container(
                    child: Image.asset('assets/flag.png', fit: BoxFit.contain),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    String titleLeading = titleKeys[index];
                    return CardItem(
                      index: index,
                      leading: titleLeading,
                      title: TITLE[titleLeading],
                      cardType: CardType.Chapter,
                    );
                  },
                  childCount: TITLE.length,
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    String scheduleTitle = scheduleKeys[index];
                    return CardItem(
                      index: index,
                      leading: scheduleTitle,
                      title: SCHEDULE[scheduleTitle],
                      cardType: CardType.Schedule,
                    );
                  },
                  childCount: 9,
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _adManager.cardPressed++;
          Navigator.of(context).pushNamed('/search');
        },
        child: Icon(Icons.search),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
