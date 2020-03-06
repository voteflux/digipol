import 'package:flutter/material.dart';
import 'package:voting_app/route_generator.dart';
import 'package:voting_app/styles.dart';

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
                data["Short Title"],
                style: TextStyle(fontSize: 30, color: appColors.text),
              ),
              Text(
                data["URL"],
                style: TextStyle(fontSize: 20, color: appColors.text),
              ),
            ],
          ),
        ),


      ),
    );
  }
}