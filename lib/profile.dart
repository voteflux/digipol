import 'package:flutter/material.dart';
import 'package:voting_app/route_generator.dart';
import 'package:voting_app/styles.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.background,
      body: Container(
        child: Center(
          child: ListView(
            children: <Widget>[
              Text(
                "User Settings",
                style: TextStyle(fontSize: 30, color: appColors.text),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
