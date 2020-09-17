import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../providers/font-manager.dart';

class FontPickerDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<FontManager>(builder: (context, fontManager, child) {
      return AlertDialog(
        title: Text('Font Size'),
        content: Container(
          height: 50,
          child: Slider(
            min: 0.5,
            max: 2.5,
            value: fontManager.fontScalefactor,
            onChanged: (value) {
              fontManager.setFontScalefactor(value);
            },
            divisions: 10,
            label: (fontManager.fontScalefactor * 14).toStringAsFixed(0),
          ),
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              fontManager.saveFont();
              Fluttertoast.showToast(
                  msg: 'Font Saved', backgroundColor: Colors.black);
              Navigator.of(context).pop();
            },
            child: Text('Save'),
          ),
        ],
      );
    });
  }
}
