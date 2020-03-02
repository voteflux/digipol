import 'package:flutter/material.dart';
import 'package:voting_app/route_generator.dart';

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
      appBar: AppBar(
        title: Text('Routing App'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Issue',
              style: TextStyle(fontSize: 50),
            ),
            Text(
              data["URL"],
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}