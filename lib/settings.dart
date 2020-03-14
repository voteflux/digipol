import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:voting_app/styles.dart';

class SettingsPage extends StatefulWidget {
  /// where the app and user settings go
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
          width: appSizes.mediumWidth,
          child: ListView(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(appSizes.standardPadding),
                child: Center(
                  child: Text(
                    "User Settings",
                    style: appTextStyles.heading,
                  ),
                ),
              ),
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
                margin: EdgeInsets.all(appSizes.standardMargin),
                elevation: appSizes.cardElevation,
                color: appColors.card,
                child: Container(
                    width: appSizes.mediumWidth,
                    height: 150,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          "User Information",
                          style: appTextStyles.standardBold,
                        ),
                        Text(
                          "You need to login to start voting",
                          style: appTextStyles.standardItalic,
                        ),
                        RaisedButton(
                          elevation: appSizes.cardElevation,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: appColors.buttonOutline, width: 2),
                            borderRadius: new BorderRadius.circular(
                                appSizes.buttonRadius),
                          ),
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
                        )
                      ],
                    )),
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(appSizes.cardCornerRadius)),
                margin: EdgeInsets.all(appSizes.standardMargin),
                elevation: appSizes.cardElevation,
                color: appColors.card,
                child: Container(
                    width: appSizes.mediumWidth,
                    height: 150,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          "Voting History",
                          style: appTextStyles.standardBold,
                        ),
                        Text(
                          "You need to login to view your voting history",
                          style: appTextStyles.standardItalic,
                        ),
                        RaisedButton(
                          elevation: appSizes.cardElevation,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: appColors.buttonOutline, width: 2),
                            borderRadius: new BorderRadius.circular(
                                appSizes.buttonRadius),
                          ),
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
                        )
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
