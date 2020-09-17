import 'package:flutter/material.dart';

import '../../views/about-us.dart';
import '../../views/about-app.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 2.0,
                child: Image.asset(
                  'assets/emblem.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            ListTile(
              leading:
                  Icon(Icons.bookmark, color: Theme.of(context).accentColor),
              title: const Text('Bookmarks'),
              onTap: () {
                Navigator.of(context).pushNamed('/bookmarks');
              },
            ),
            ListTile(
              leading:
                  Icon(Icons.color_lens, color: Theme.of(context).accentColor),
              title: const Text('Change Theme'),
              onTap: () {
                Navigator.of(context).pushNamed('/themes');
              },
            ),
            ListTile(
              leading: Icon(Icons.account_circle,
                  color: Theme.of(context).accentColor),
              title: const Text('About Us'),
              onTap: () {
                Navigator.of(context).pushNamed(AboutUs.routeName);
              },
            ),
            ListTile(
              leading:
                  Icon(Icons.android, color: Theme.of(context).accentColor),
              title: const Text('About App'),
              onTap: () {
                Navigator.of(context).pushNamed(AboutApp.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}
