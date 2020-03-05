import 'package:flutter/material.dart';
import 'package:voting_app/route_generator.dart';

class ProfilePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: ListView(
            children: <Widget>[
              Text(
                "User Settings",
                style: TextStyle(fontSize: 30),
              ),
            ],
          ),
        ),


      ),
    );
  }
}