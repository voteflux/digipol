
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:flutter_svg/svg.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:voting_app/core/router.gr.dart';
import 'package:voting_app/core/services/wallet.dart';
import 'package:voting_app/core/viewmodels/settings_model.dart';
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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  var version = "...";

  @override
  void initState() {
    super.initState();

    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      setState(() {
        print(packageInfo.version);
        version = packageInfo.version;
      });
    });
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
      onModelReady: (model) => print('user'),
      builder: (context, model, child) => Scaffold(
        key: _scaffoldKey,
        // Disable opening the end drawer with a swipe gesture.
        body: Align(
          alignment: Alignment.topCenter,
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    height: 50,
                    child: Text(
                      'Settings',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    width: appSizes.mediumWidth,
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        _account(),
                        Divider(color: Theme.of(context).colorScheme.secondary),
                        SizedBox(height: 10),
                        _helpAndInfo(),
                        Divider(color: Theme.of(context).colorScheme.secondary),
                        SizedBox(height: 10),
                        _community(),
                        // Divider(color: Theme.of(context).colorScheme.secondary),
                        // _appearance(),
                        Divider(color: Theme.of(context).colorScheme.secondary),
                        // _notifications(),
                        // SizedBox(height: 30),
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
        Align(child: Text(
          "Account",
          style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 14,
              fontWeight: FontWeight.w700),
        ), alignment: Alignment.center),
        SettingEntry("Change username", () {
          print("change username");
        }),
        SettingEntry("Change pin", () {
          print("change pin");
        }),
      ],
    );
  }

  Widget _appearance() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(child: Text(
          "Apprearance",
          style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 14,
              fontWeight: FontWeight.w700),
        ), alignment: Alignment.center),
        SettingEntry("Language (coming soon)", () {
          print("change language");
        }),
        SettingEntry("Dark / light (coming soon)", () {
          print("change theme");
        }),
      ],
    );
  }

  Widget _helpAndInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(child: Text(
          "Help and Info",
          style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 14,
              fontWeight: FontWeight.w700),
        ), alignment: Alignment.center),
        Container(
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("App Version",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 14,
                  fontWeight: FontWeight.w400
                ),
              ),
              Text(version,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 14,
                    fontWeight: FontWeight.w400
                ),
              )
            ]
          )
        ),
        SettingEntry("Revisit introduction", () {
          Navigator.pushNamed(context, Routes.onBoardingView);
        }),
        SettingEntry("Submit an issue/feedback", () {
          //launch("TODO: Google forms link");
        }),
        // SettingEntry("App version", () {
        //   print("App version");
        // }),
        SettingEntry("Security info", () {
          print("Security info");
        })
      ]
    );
  }

  Widget _community() {
     return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "Join the Flux Community!",
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 14,
              fontWeight: FontWeight.w700
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          SignInButton(
            Buttons.FacebookNew,
            text: "Like us on Facebook",
            onPressed: () {
              launch("https://www.facebook.com/VoteFlux.org");
            }
          ),
          SizedBox(height: 10),
          SignInButton(
            Buttons.Twitter,
            text: "Follow our Twitter",
            onPressed: () {
              launch("https://twitter.com/voteflux");
            },
          ),
          SizedBox(height: 10),
          SignInButtonBuilder(
            text: "Join our Discord",
            image: SvgPicture.asset("assets/graphics/discord-logo.svg", width: 20),
            iconColor: Colors.white,
            onPressed: () {
              launch("https://discord.io/FluxParty");
            },
            backgroundColor: Color.fromRGBO(114,137,218,1),
          ),
          SizedBox(height: 10),
          SignInButton(
            Buttons.GitHub,
            text: "Follow our Github",
            onPressed: () {
              launch("https://github.com/voteflux/");
            },
          ),
          SizedBox(height: 10),
          SignInButton(
            Buttons.Email,
            text: "Send us an Email",
            onPressed: () {
              launch("mailto://digipol@voteflux.org");
            },
          )
        ]
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
      minWidth: 100,
      height: 30,
      padding: EdgeInsets.symmetric(vertical: 5),
      color: Theme.of(context).colorScheme.secondary,
      onPressed: () {
        //TODO: Lock system
      },
      child: Text(
        'Sign out',
        style: TextStyle(fontSize: 14),
      ),
    );
  }

  Widget SettingEntry(String text, Function func) {
    return FlatButton(
      height: 40,
      onPressed: () { func(); },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 14,
              fontWeight: FontWeight.w400
            ),
          ),
          Icon(
            Icons.arrow_forward_ios_rounded,
            color: Theme.of(context).colorScheme.primary,
            size: 16
          ),
        ],
      ),
    );
  }
}
