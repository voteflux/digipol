import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InLineIcon extends StatelessWidget {
  static const String _ICON    = '<icon';
  static const String _IMAGE   = '<image';
  static const String _BOLD    = '<b';
  final String _assets_path = 'assets/graphics/';
  final double _iconSize = 20.0;
  final double _imgHeight = 32.0;
  final String text;

  InLineIcon(
      {Key /*?*/ key,
        @required this.text})
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
    switch(parameters[0]) {
      case _BOLD:
        return TextSpan(text: parameters[1],
          style: Theme.of(context).textTheme.bodyText1,
        );
      case _ICON:
        return WidgetSpan(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 1.0),
                child: Icon(
                    IconData(int.parse(parameters[1]),
                        fontFamily: 'MaterialIcons'
                    ),
                  size: _iconSize,
                )
            )
        );
      case _IMAGE:
        return WidgetSpan(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: Image.asset(_assets_path + parameters[1],
                  height: _imgHeight,
              )
          ),
        );
    }
    return TextSpan();
  }

}
