import 'package:flutter/material.dart';
import 'package:voting_app/route_generator.dart';

class BillPage extends StatelessWidget {
  // This is a String for the sake of an example.
  // You can use any type you want.
  final Map data;

  BillPage({
    Key key,
    @required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vote on Bill'),
      ),
      body: Container(
        child: Center(
          child: ListView(
            children: <Widget>[
              Text(
                data["Short Title"],
                style: TextStyle(fontSize: 30),
              ),
              Text(
                data["URL"],
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),


      ),
    );
  }
}