import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InLineIcon extends StatelessWidget {

  final String _assets_path = 'assets/graphics/';
  final double _iconHeight = 32.0;
  final String text;

  InLineIcon(
      {Key /*?*/ key,
        @required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // extract icon filenames from the input text `text`
    var lines = text.split('`');
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          style: Theme.of(context).textTheme.bodyText1,
          children: [for(var index = 0; index < lines.length; index++)
            _inLineSpan(lines, index)]
      ),
    );
  }

  InlineSpan _inLineSpan(List<String> lines, int index) {
    // return WidgetSpan to display icon when it's a filename line,
    // otherwise, return a TextSpan.
    if(index.isEven)
      return TextSpan(text: lines[index]);
    else
      return WidgetSpan(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2.0),
          child: Image.asset(_assets_path + lines[index], height: _iconHeight)
        ),
      );
  }

}
