import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/theme-manager.dart';
import '../controllers/theme.dart';

class ThemeChooser extends StatelessWidget {
  const ThemeChooser({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Themes')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: AppTheme.values.length,
          itemBuilder: (context, index) {
            final theme = AppTheme.values[index];
            return Card(
              color: appThemeData[theme].primaryColor,
              child: ListTile(
                onTap: () {
                  Provider.of<ThemeManager>(context, listen: false)
                      .setTheme(theme);
                },
                title: Text(
                  enumName(theme),
                  style: appThemeData[theme].textTheme.headline5,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
