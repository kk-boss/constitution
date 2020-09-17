import 'package:flutter/material.dart';

import './widgets/card-text.dart';

class AboutApp extends StatelessWidget {
  static const String routeName = '/about-app';
  const AboutApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About App'),
      ),
      body: ListView(
        children: <Widget>[
          const CardText(
            text: 'Terms and Conditions',
            textStyle: TextStyle(fontWeight: FontWeight.bold),
          ),
          const CardText(
            text:
                'We allow third-party company to serve ads and collect certain anonymous information when you visit our app. These company may use anonymous information such as your Google Advertising ID, your device type and version, browsing activity, location and other technical data relating to your device, in order to provide advetisements.',
          ),
          const Divider(
            thickness: 2.0,
          ),
          const CardText(
            text: 'Disclaimer',
            textStyle: TextStyle(fontWeight: FontWeight.bold),
          ),
          const Padding(
            padding: const EdgeInsets.only(bottom: 30.0),
            child: const CardText(
              text:
                  'This app is developed by: Santosh Thapa as an ad supported app.\nAll the content implemented in the app are sourced from Official Site of Nepal Law Commission.',
            ),
          ),
        ],
      ),
    );
  }
}
