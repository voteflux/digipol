import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InLineIcon extends StatelessWidget {
  static const String _IMAGE          = '<image';
  static const String _BOLD           = '<b';
  static const String _ASSETS_PATH    = 'assets/graphics/';
  final String text;

  InLineIcon( this.text,
      {Key /*?*/ key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // extract icon/image filenames from the input text
    var lines = text.split(new RegExp(r'(?=<)|>'));
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          style: Theme.of(context).textTheme.bodyText2,
          children: [for(var line in lines) _inLineSpan(context, line)]
      ),
    );
  }

  InlineSpan _inLineSpan(BuildContext context, String line) {
    // if the first character is not '<', return a plain text
    if(line[0] != '<')
      return TextSpan(text: line);

    // otherwise, return an icon or image
    var parameters = line.split(':');
    try {
      switch(parameters[0]) {
        case _BOLD:
          return TextSpan(text: parameters[1],
            style: Theme.of(context).textTheme.bodyText1,
          );
        case _IMAGE:
          return WidgetSpan(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: Image.asset(_ASSETS_PATH + parameters[1],
                  height: double.parse(parameters[2]),
                )
            ),
          );
      }
    } on Exception catch(_) {

    }
    return TextSpan();
  }

}
