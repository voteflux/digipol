import 'package:flutter/material.dart';
import 'package:voting_app/route_generator.dart';


class AllIssuesPage extends StatelessWidget {
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
              'Issues Page',
              style: TextStyle(fontSize: 50),
            ),
            RaisedButton(
              child: Text('Go to Issue'),
              onPressed: () {
                // Pushing a named route
                Navigator.of(context).pushNamed(
                  '/issue',
                  arguments: '{pass issue data}',
                );
              },
            )
          ],
        ),
      ),
    );
  }
}