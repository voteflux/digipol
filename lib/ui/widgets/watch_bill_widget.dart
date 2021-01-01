import 'package:flutter/material.dart';
import 'package:voting_app/core/consts.dart';
import 'package:hive/hive.dart';

class WatchBillWidget extends StatefulWidget {
  final String id;

  WatchBillWidget({Key key, @required this.id}) : super(key: key);
  @override
  _WatchBillWidgetState createState() => _WatchBillWidgetState();
}

class _WatchBillWidgetState extends State<WatchBillWidget> {
  final Box<List> userWatchedBills = Hive.box<List>(HIVE_USER_PREFS_LIST);
  bool _active = false;
  void _configureWatchedBills(String id) {
    List<String> blankBillIds = [];
    List<String> finalBillIds = [];

    List<String> billIds = userWatchedBills
        .get(USER_WATCHED_BILLS, defaultValue: blankBillIds)
        .cast<String>();

    finalBillIds.addAll(billIds);

    finalBillIds.contains(id)
        ? finalBillIds.removeWhere((tag) => tag == id)
        : finalBillIds.add(id);

    setState(() {
      if (finalBillIds.contains(id)) {
        _active = true;
      } else {
        _active = false;
      }
    });
    userWatchedBills.put(USER_WATCHED_BILLS, finalBillIds);
    print(finalBillIds);
  }

  @override
  void initState() {
    checkActive(widget.id);
  }

  void checkActive(String id) {
    List<dynamic> billIds = userWatchedBills.get(USER_WATCHED_BILLS);
    if (billIds != null && billIds.contains(id)) {
      _active = true;
    } else {
      _active = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return OutlineButton.icon(
      splashColor: Theme.of(context).colorScheme.primaryVariant,
      textColor: Theme.of(context).colorScheme.primaryVariant,
      onPressed: () {
        _configureWatchedBills(widget.id);
      },
      icon: Icon(
        Icons.visibility,
        color: _active
            ? Theme.of(context).colorScheme.primaryVariant
            : Theme.of(context).colorScheme.onSurface,
      ),
      label: Text(
        _active ? "Watching" : "Watch",
        style: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 12,
          color: _active
              ? Theme.of(context).colorScheme.primaryVariant
              : Theme.of(context).colorScheme.onSurface,
        ),
      ),
    );
  }
}
