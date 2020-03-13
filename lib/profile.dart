import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:voting_app/route_generator.dart';
import 'package:voting_app/styles.dart';




class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    if (darkMode){
      appColors = AppColors(0);
    }else{
      appColors = AppColors(1);
    }
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Dark mode", style: appTextStyles.standardBold,),
                  Container(
                    width: 70,
                    child: Switch(
                      materialTapTargetSize: MaterialTapTargetSize.padded,
                      value: darkMode,
                      onChanged: (value) {
                        setState(() {
                          darkMode = value;
                          print(darkMode);
                        });
                      },
                      activeTrackColor: Colors.lightBlue,
                      activeColor: Colors.blue,
                    ),

                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
