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

import '../../locator.dart';

class SettingsPage extends StatefulWidget {
  // where the app and user settings go
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String pubKey = "";
  final WalletService walletService = locator<WalletService>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getPubKey();
    });
  }

  Future getPubKey() async {
    var ethAddress = await walletService.ethereumAddress();
    pubKey = ethAddress.toString();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<SettingsModel>(
      onModelReady: (model) => model.setUser(),
      builder: (context, model, child) => Scaffold(
        body: Center(
          child: Container(
            padding: EdgeInsets.only(top: 10),
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
                  //ListTile(
                  //tileColor: Theme.of(context).colorScheme.secondary,
                  //title: Text("Cheezburger"),
                  //),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    width: appSizes.mediumWidth,
                    child: Column(
                      children: [
                        _account(),
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
    );
  }

  Widget _account() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 30,
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
              "Account",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 14,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ),
        SizedBox(
          height: 30,
          child: ListTile(
            onTap: () {},
            contentPadding: EdgeInsets.zero,
            title: Text(
              'Change username',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 14,
              ),
            ),
            trailing: Icon(Icons.arrow_forward_ios_rounded,
                size: 14, color: Theme.of(context).colorScheme.primary),
          ),
        ),
        ListTile(
          onTap: () {},
          contentPadding: EdgeInsets.zero,
          title: Text(
            'Change pin',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 14,
            ),
          ),
          trailing: Icon(Icons.arrow_forward_ios_rounded,
              size: 14, color: Theme.of(context).colorScheme.primary),
        ),
      ],
    );
  }

  Widget _apprearance() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 30,
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
              "Appearance",
              style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ),
        SizedBox(
          height: 30,
          child: ListTile(
            onTap: () {},
            contentPadding: EdgeInsets.zero,
            title: Text(
              'Language (coming soon)',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 14,
              ),
            ),
            trailing: Icon(Icons.arrow_forward_ios_rounded,
                size: 14, color: Theme.of(context).colorScheme.primary),
          ),
        ),
        ListTile(
          onTap: () {},
          contentPadding: EdgeInsets.zero,
          title: Text(
            'Dark / light (coming soon)',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 14,
            ),
          ),
          trailing: Icon(Icons.arrow_forward_ios_rounded,
              size: 14, color: Theme.of(context).colorScheme.primary),
        ),
      ],
    );
  }

  Widget _digipol() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 30,
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
              "DigiPol",
              style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ),
        SizedBox(
          height: 30,
          child: ListTile(
            onTap: () {},
            contentPadding: EdgeInsets.zero,
            title: Text(
              'Restart quiz (coming soon)',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 14,
              ),
            ),
            trailing: Icon(Icons.arrow_forward_ios_rounded,
                size: 14, color: Theme.of(context).colorScheme.primary),
          ),
        ),
        SizedBox(
          height: 30,
          child: ListTile(
            onTap: () {},
            contentPadding: EdgeInsets.zero,
            title: Text(
              'Submit an issue',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 14,
              ),
            ),
            trailing: Icon(Icons.arrow_forward_ios_rounded,
                size: 14, color: Theme.of(context).colorScheme.primary),
          ),
        ),
        SizedBox(
          height: 30,
          child: ListTile(
            onTap: () {},
            contentPadding: EdgeInsets.zero,
            title: Text(
              'Join us on Discord chat',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 14,
              ),
            ),
            trailing: Icon(Icons.arrow_forward_ios_rounded,
                size: 14, color: Theme.of(context).colorScheme.primary),
          ),
        ),
        SizedBox(
          height: 30,
          child: ListTile(
            onTap: () {},
            contentPadding: EdgeInsets.zero,
            title: Text(
              'App version',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 14,
              ),
            ),
            trailing: Icon(Icons.arrow_forward_ios_rounded,
                size: 14, color: Theme.of(context).colorScheme.primary),
          ),
        ),
        ListTile(
          onTap: () {},
          contentPadding: EdgeInsets.zero,
          title: Text(
            'Security info',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 14,
            ),
          ),
          trailing: Icon(Icons.arrow_forward_ios_rounded,
              size: 14, color: Theme.of(context).colorScheme.primary),
        ),
      ],
    );
  }

  Widget _notifications() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 30,
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
              "Notifications",
              style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ),
        SizedBox(
          height: 30,
          child: ListTile(
            onTap: () {},
            contentPadding: EdgeInsets.zero,
            title: Text(
              'Push notifications',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 14,
              ),
            ),
            trailing: Icon(Icons.arrow_forward_ios_rounded,
                size: 14, color: Theme.of(context).colorScheme.primary),
          ),
        ),
        ListTile(
          onTap: () {},
          contentPadding: EdgeInsets.zero,
          title: Text(
            'Edit preferences',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 14,
            ),
          ),
          trailing: Icon(Icons.arrow_forward_ios_rounded,
              size: 14, color: Theme.of(context).colorScheme.primary),
        ),
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
      padding: EdgeInsets.symmetric(vertical: 5),
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
            "Cheezburger",
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
}
