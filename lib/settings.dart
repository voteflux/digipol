import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:voting_app/styles.dart';




class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
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
                "Page Under Construction...",
                style: TextStyle(fontSize: 30, color: Colors.red),
              ),
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
              ),
              RaisedButton(
                  onPressed: (){
                    Navigator.of(context).pushNamed(
                      '/profile',
                    );
                  },
                child: Text("Login", style: appTextStyles.yesnobutton,),
              )
            ],
          ),
        ),
      ),
    );
  }
}