import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/font-manager.dart';

class CardText extends StatelessWidget {
  const CardText(
      {Key key, @required this.text, this.textStyle, this.iconButton})
      : super(key: key);

  final String text;
  final TextStyle textStyle;
  final IconButton iconButton;

  @override
  Widget build(BuildContext context) {
    return Consumer<FontManager>(builder: (context, fontManager, child) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(
          10.0,
        ),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          // color: Colors.amber,
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    text,
                    textScaleFactor: fontManager.fontScalefactor * 1.2,
                    style: textStyle,
                  ),
                ),
                if (iconButton != null) iconButton
              ],
            ),
          ),
        ),
      );
    });
  }
}
