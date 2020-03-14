import 'package:flutter/material.dart';
import 'package:voting_app/styles.dart';
import 'package:voting_app/cutom_widgets.dart';
import 'package:voting_app/voting_widgets.dart';

class IssuePage extends StatelessWidget {
  // This is a String for the sake of an example.
  // You can use any type you want.
  final Map data;

  IssuePage({
    Key key,
    @required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.background,
      appBar: AppBar(
        title: Text('Vote on Issue'),
      ),
      body: Container(
        child: Center(
          child: ListView(
            children: <Widget>[
              Text(
                "Page Under Construction",
                style: TextStyle(fontSize: 30, color: Colors.red),
              ),
              Text(
                data["Short Title"],
                style: TextStyle(fontSize: 30, color: appColors.text),
              ),
              Text(
                data["Summary"],
                style: TextStyle(fontSize: 25, color: appColors.text),
              ),
              PieWidget(yes: data["Yes"],no: data["No"],radius: 300,),
              Text(
                data["Description"],
                style: TextStyle(fontSize: 20, color: appColors.text),
              ),
              VoteWidget(data: data),
            ],
          ),
        ),
      ),
    );
  }
}
