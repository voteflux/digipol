import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:voting_app/core/services/wallet.dart';
import 'package:voting_app/core/viewmodels/settings_model.dart';
import 'package:voting_app/core/viewmodels/theme_model.dart';
import 'package:voting_app/ui/styles.dart';
import 'package:voting_app/ui/views/base_view.dart';
import 'package:hive/hive.dart';
import '../../core/consts.dart';

import '../../locator.dart';

class SettingsPage extends StatefulWidget {
  // where the app and user settings go
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String pubKey = "";
  final WalletService walletService = locator<WalletService>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Drawer drawer = Drawer(key: UniqueKey());

  Box userBox = Hive.box<String>(HIVE_USER_PREFS_STR);

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   getPubKey();
    // });
  }

  // Future getPubKey() async {
  //   var ethAddress = await walletService.ethereumAddress();
  //   pubKey = ethAddress.toString();
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return BaseView<SettingsModel>(
      onModelReady: (model) => model.setUser(),
      builder: (context, model, child) => Scaffold(
        key: _scaffoldKey,
        // Disable opening the end drawer with a swipe gesture.
        endDrawer: drawer,
        body: Builder(
          builder: (context) => Align(
            alignment: Alignment.topCenter,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Text(
                      "Settings",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 10),
                    _userProfile(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      width: appSizes.mediumWidth,
                      child: Column(
                        children: [
                          SizedBox(height: 20),
                          _account(context),
                          Divider(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          _apprearance(),
                          Divider(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          _notifications(),
                          Divider(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          _digipol(),
                          SizedBox(height: 30),
                          _signout(),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _account(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Account",
          style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 14,
              fontWeight: FontWeight.w700),
        ),
        SettingEntry("Change username", () {
          setState(() {
            drawer = Drawer(
              key: UniqueKey(),
              child: FlatButton(
                child: Text(userBox.get('firstName') as String),
                onPressed: () {
                  userBox.put('firstName', 'emma');
                  Navigator.of(context).pop();
                },
              ),
            );
          });
          //_scaffoldKey.currentState.openEndDrawer();
          Scaffold.of(context).openEndDrawer();
        }),
        SettingEntry("Change pin", () {
          setState(() {
            drawer = Drawer(
              key: UniqueKey(),
              child: FlatButton(
                child: Text('close'),
                onPressed: () {
                  userBox.put('pincode', '1111');
                  Navigator.of(context).pop();
                },
              ),
            );
          });
          //_scaffoldKey.currentState.openEndDrawer();
          Scaffold.of(context).openEndDrawer();
        }),
      ],
    );
  }

  Widget _apprearance() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Apprearance",
          style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 14,
              fontWeight: FontWeight.w700),
        ),
        SettingEntry("Language (coming soon)", () {
          print("change language");
        }),
        SettingEntry("Dark / light (coming soon)", () {
          print("change theme");
        }),
      ],
    );
  }

  Widget _digipol() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "DigiPol",
          style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 14,
              fontWeight: FontWeight.w700),
        ),
        SettingEntry("Restart quiz (coming soon)", () {
          print("restart quiz");
        }),
        SettingEntry("Submit an issue", () {
          print("Submit an issue");
        }),
        SettingEntry("Join us on Discord chat", () {
          print("Join us on Discord chat");
        }),
        SettingEntry("App version", () {
          print("App version");
        }),
        SettingEntry("Security info", () {
          print("Security info");
        }),
      ],
    );
  }

  Widget _notifications() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Notifications",
          style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 14,
              fontWeight: FontWeight.w700),
        ),
        SettingEntry("Push notifications", () {
          print("Push notifications");
        }),
        SettingEntry("Edit preference", () {
          print("Edit preference");
        }),
      ],
    );
  }

  Widget _signout() {
    return MaterialButton(
      minWidth: 80,
      height: 15,
      padding: EdgeInsets.symmetric(vertical: 5),
      color: Theme.of(context).colorScheme.secondary,
      onPressed: () {},
      child: Text(
        'Sign out',
        style: TextStyle(fontSize: 14),
      ),
    );
  }

  Widget _userProfile() {
    return Container(
      alignment: Alignment.center,
      height: 60,
      color: Theme.of(context).colorScheme.secondary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Theme.of(context).backgroundColor,
            child: Icon(Icons.person,
                size: 38, color: Theme.of(context).colorScheme.onSurface),
          ),
          SizedBox(width: 20),
          Text(
            userBox.get('firstName') as String,
            style: TextStyle(
              color: Theme.of(context).backgroundColor,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget SettingEntry(String text, Function func) {
    return Container(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 14,
            ),
          ),
          IconButton(
            iconSize: 16,
            icon: Icon(Icons.arrow_forward_ios_rounded,
                color: Theme.of(context).colorScheme.primary),
            onPressed: () {
              func();
            },
          ),
        ],
      ),
    );
  }
}
