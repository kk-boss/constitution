import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/custom_icons.dart';

class AboutUs extends StatelessWidget {
  static const String routeName = '/about';
  const AboutUs({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About Us')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            const Text(
              'Developer:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Card(
                elevation: 5.0,
                child: Image.asset('assets/santosh.jpg', fit: BoxFit.cover),
              ),
            ),
            Divider(),
            const Text(
              'Santosh Thapa Magar',
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.blue),
              softWrap: true,
              textAlign: TextAlign.center,
            ),
            Divider(),
            const Text(
              'Contact Us:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                IconButton(
                    icon: Icon(
                      CustomIcons.facebook,
                      color: Colors.blue,
                    ),
                    onPressed: () async {
                      const _url = 'https://www.facebook.com/santoshthapa896';
                      if (await canLaunch(_url)) {
                        await launch(_url);
                      }
                    }),
                IconButton(
                    icon: Icon(
                      CustomIcons.instagram,
                      color: Colors.blue,
                    ),
                    onPressed: () async {
                      const _url = 'https://www.instagram.com/new.santosh.3/';
                      if (await canLaunch(_url)) {
                        await launch(_url);
                      }
                    }),
                IconButton(
                    icon: Icon(
                      CustomIcons.twitter,
                      color: Colors.blue,
                    ),
                    onPressed: () async {
                      const _url = 'https://twitter.com/newsantosh3';
                      if (await canLaunch(_url)) {
                        await launch(_url);
                      }
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
