import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:voting_app/styles.dart';
import 'package:voting_app/custom_widgets.dart';

class SettingsPage extends StatefulWidget {
  // where the app and user settings go
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    if (darkMode) {
      appColors = AppColors(0);
    } else {
      appColors = AppColors(1);
    }
    return Scaffold(
      backgroundColor: appColors.background,
      body: Center(
        child: Container(
          padding: EdgeInsets.all(appSizes.standardPadding),
          width: appSizes.mediumWidth,
          child: ListView(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Dark mode",
                    style: appTextStyles.standardBold,
                  ),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Notifications",
                    style: appTextStyles.standardBold,
                  ),
                  Container(
                    width: 70,
                    child: Switch(
                      materialTapTargetSize: MaterialTapTargetSize.padded,
                      value: false,
                      onChanged: (value) {
                        print("Notifications... ");
                      },
                      activeTrackColor: Colors.lightBlue,
                      activeColor: Colors.blue,
                    ),
                  )
                ],
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(appSizes.cardCornerRadius)),
                elevation: appSizes.cardElevation,
                color: appColors.card,
                child: Container(
                    padding: const EdgeInsets.all(20.0),
                    width: appSizes.mediumWidth,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          "User Information",
                          style: appTextStyles.standardBold,
                        ),
                        Text(
                          "You need to login to start voting",
                          style: appTextStyles.small,
                        ),
                        SizedBox(
                          width: double.infinity,
                            child: RaisedButton(
                          elevation: appSizes.cardElevation,
                          color: appColors.button,
                          onPressed: () {
                            Navigator.of(context).pushNamed(
                              '/profile',
                            );
                          },
                          child: Text(
                            "Login",
                            style: appTextStyles.yesnobutton,
                          ),
                        )),
                        SizedBox(
                          width: double.infinity,
                            child: RaisedButton(
                          elevation: appSizes.cardElevation,
                          color: appColors.button,
                          onPressed: () {
                            Navigator.of(context).pushNamed(
                              '/profile',
                            );
                          },
                          child: Text(
                            "Create Account",
                            style: appTextStyles.yesnobutton,
                          ),
                        ))
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
