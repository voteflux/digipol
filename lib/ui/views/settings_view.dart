import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voting_app/core/viewmodels/settings_model.dart';
import 'package:voting_app/core/viewmodels/theme_model.dart';
import 'package:voting_app/ui/styles.dart';
import 'package:voting_app/ui/views/base_view.dart';
import 'dart:async';
import 'package:voting_app/core/services/wallet.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatefulWidget {
  // where the app and user settings go
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String pubKey = "";

  @override
  Widget build(BuildContext context) {
    Future getPubKey() async {
      var walletService = WalletService(null);
      var ethAddress = await walletService.ethereumAddress();
      pubKey = ethAddress.toString();
      setState(() {});
    }

    return BaseView<SettingsModel>(
      onModelReady: (model) => model.setUser(),
      builder: (context, model, child) => Scaffold(
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
                        value: Provider.of<ThemeModel>(context).isDarkMode,
                        onChanged: (value) {
                          setState(() {
                            Provider.of<ThemeModel>(context, listen: false)
                                .updateTheme(value);
                          });
                        },
                        activeTrackColor: Theme.of(context).colorScheme.primary,
                        activeColor: Theme.of(context).colorScheme.primary,
                      ),
                    )
                  ],
                ),
//                Divider(thickness: 2.0,),
//                Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                  children: <Widget>[
//                  RaisedButton(
//                    color: Colors.red,
//                        onPressed: () {
//                          model.clearUser();
//                          Navigator.pop(context, '/profile');
//                        },
//                        child: Text('Log out'),
//                      ),
//                  ],
//                ),
                Divider(
                  thickness: 2.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    RaisedButton(
                      color: Colors.red,
                      onPressed: () {
                        setState(() {
                          getPubKey();
                        });
                      },
                      child: Text('  Show Public Key  '),
                    ),
                  ],
                ),
                Text(
                  pubKey,
                  style: appTextStyles.standardBold,
                ),
                Divider(
                  thickness: 2.0,
                ),
                Column(
                  children: <Widget>[
                    Text(
                      "App details",
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    Text(
                      "v0.1.5",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    Divider(
                      thickness: 1.0,
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Please submit issues into the ',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          TextSpan(
                            text: 'Github issues page.',
                            style:
                                TextStyle(color: Colors.blue, fontSize: 16.0),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                launch(
                                    'https://github.com/voteflux/voting_app/issues/new/choose');
                              },
                          ),
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Join us on ',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          TextSpan(
                            text: 'Discord',
                            style:
                                TextStyle(color: Colors.blue, fontSize: 16.0),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                launch('https://discord.gg/xFMUTZw');
                              },
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
