import 'package:flutter/material.dart';

class WatchBillWidget extends StatefulWidget {
  @override
  _WatchBillWidgetState createState() => _WatchBillWidgetState();
}

class _WatchBillWidgetState extends State<WatchBillWidget> {
  @override
  Widget build(BuildContext context) {
    return OutlineButton.icon(
      splashColor: Theme.of(context).colorScheme.onSurface,
      textColor: Theme.of(context).colorScheme.onSurface,
      onPressed: () {},
      icon: Icon(
        Icons.visibility,
        color: Theme.of(context).colorScheme.onSurface,
      ),
      label: Text("Watch",
          style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 12,
              color: Theme.of(context).colorScheme.onSurface)),
    );
  }
}
