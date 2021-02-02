import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:flutter_svg/svg.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:voting_app/core/router.gr.dart';
import 'package:voting_app/core/services/wallet.dart';
import 'package:voting_app/core/viewmodels/settings_model.dart';
import 'package:voting_app/ui/styles.dart';
import 'package:voting_app/ui/views/base_view.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:hive/hive.dart';
import '../../core/consts.dart';

import '../../locator.dart';

class SettingsPage extends StatefulWidget {
  // where the app and user settings go
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final TextEditingController _userName = TextEditingController();
  final TextEditingController _pinCode = TextEditingController();
  final TextEditingController _oldPinCode = TextEditingController();
  final TextEditingController _newPinCode = TextEditingController();
  final TextEditingController _confirmNewPin = TextEditingController();
  final WalletService walletService = locator<WalletService>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Widget drawer = Drawer(key: UniqueKey());

  Box userBox = Hive.box<String>(HIVE_USER_PREFS_STR);
  //TODO: display error message when old pin incorrect or two new pins don't match
  //bool error = false;
  //String errorMsg = '';

  String version = "...";
  String pubKey = "";

  @override
  void initState() {
    super.initState();

    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      setState(() {
        version = packageInfo.version;
      });
    });
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   getPubKey();
    // });
  }

  Future getPubKey() async {
    var ethAddress = await walletService.ethereumAddress();
    setState(() {
      pubKey = ethAddress.toString();
    });
  }

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
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            width: appSizes.mediumWidth,
                            child: Column(
                              children: [
                                _account(context),
                                SizedBox(height: 10),
                                _helpAndInfo(),
                                Divider(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
                                // SizedBox(height: 10),
                                // _account(),
                                // Divider(color: Theme.of(context).colorScheme.secondary),
                                SizedBox(height: 10),
                                _community(),
                                // Divider(color: Theme.of(context).colorScheme.secondary),
                                // _appearance(),
                                Divider(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
                                // _notifications(),
                                // SizedBox(height: 30),
                                _signout(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ));
  }

  Widget _account(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
            child: Text(
              "Account",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 14,
                  fontWeight: FontWeight.w700),
            ),
            alignment: Alignment.center),
        SettingEntry("Change username", () {
          setState(() {
            drawer = Drawer(
              key: UniqueKey(),
              child: Container(
                padding: EdgeInsets.all(10),
                color: Theme.of(context).cardTheme.color,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                          IconButton(
                            color: Theme.of(context).colorScheme.primary,
                            icon: Icon(Icons.close),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                "Profile",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      CircleAvatar(
                        radius: 45,
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary,
                        child: Icon(Icons.person,
                            size: 60, color: Theme.of(context).backgroundColor),
                      ),
                      SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Username",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextField(
                          controller: _userName,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Theme.of(context).cardTheme.color,
                              border: OutlineInputBorder(),
                              hintStyle: Theme.of(context).textTheme.bodyText1,
                              hintText: 'New username')),
                      SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Your pin",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      PinCodeTextField(
                          controller: _pinCode,
                          pinBoxWidth: 45,
                          pinBoxHeight: 50,
                          pinTextStyle: TextStyle(
                              fontSize: 18,
                              color: Theme.of(context).colorScheme.primary),
                          onDone: (text) {
                            print(text);
                          },
                          highlight: true,
                          highlightColor: Theme.of(context).colorScheme.primary,
                          //highlightPinBoxColor:
                          //Theme.of(context).colorScheme.onSurface,
                          maxLength: 4,
                          hasUnderline: false,
                          pinBoxColor: Theme.of(context).cardTheme.color,
                          defaultBorderColor:
                              Theme.of(context).colorScheme.onSurface,
                          pinBoxRadius: 10.0,
                          hasTextBorderColor:
                              Theme.of(context).colorScheme.primary),
                      SizedBox(height: 30),
                      RaisedButton(
                        child: Text("Update"),
                        onPressed: () {
                          if (_pinCode.text == userBox.get('pincode')) {
                            userBox.put('firstName', _userName.text);
                            final snackBar = SnackBar(
                              content: Text('User name has been changed'),
                            );
                            Navigator.of(context).pop();
                            Future.delayed(Duration(milliseconds: 300), () {
                              Scaffold.of(context).showSnackBar(snackBar);
                            });
                          }
                          ;
                        },
                      ),
                    ],
                  ),
                ),
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
              child: Container(
                padding: EdgeInsets.all(10),
                color: Theme.of(context).cardTheme.color,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                          IconButton(
                            color: Theme.of(context).colorScheme.primary,
                            icon: Icon(Icons.close),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                "Profile",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      CircleAvatar(
                        radius: 45,
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary,
                        child: Icon(Icons.person,
                            size: 60, color: Theme.of(context).backgroundColor),
                      ),
                      SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Old pin",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      PinCodeTextField(
                          controller: _oldPinCode,
                          pinBoxWidth: 45,
                          pinBoxHeight: 50,
                          pinTextStyle: TextStyle(
                              fontSize: 18,
                              color: Theme.of(context).colorScheme.primary),
                          onDone: (text) {
                            //TODO: check is old pin correct
                            //if (text != userBox.get('pincode')) {
                            //setState(() {
                            //error = true;
                            //});
                            //} else {
                            //setState(() {
                            //error = false;
                            //});
                            //}
                          },
                          highlight: true,
                          highlightColor: Theme.of(context).colorScheme.primary,
                          //highlightPinBoxColor:
                          //Theme.of(context).colorScheme.onSurface,
                          maxLength: 4,
                          hasUnderline: false,
                          pinBoxColor: Theme.of(context).cardTheme.color,
                          defaultBorderColor:
                              Theme.of(context).colorScheme.onSurface,
                          pinBoxRadius: 10.0,
                          hasTextBorderColor:
                              Theme.of(context).colorScheme.primary),
                      SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "New pin",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      PinCodeTextField(
                          controller: _newPinCode,
                          pinBoxWidth: 45,
                          pinBoxHeight: 50,
                          pinTextStyle: TextStyle(
                              fontSize: 18,
                              color: Theme.of(context).colorScheme.primary),
                          onDone: (text) {
                            print(text);
                          },
                          highlight: true,
                          highlightColor: Theme.of(context).colorScheme.primary,
                          //highlightPinBoxColor:
                          //Theme.of(context).colorScheme.onSurface,
                          maxLength: 4,
                          hasUnderline: false,
                          pinBoxColor: Theme.of(context).cardTheme.color,
                          defaultBorderColor:
                              Theme.of(context).colorScheme.onSurface,
                          pinBoxRadius: 10.0,
                          hasTextBorderColor:
                              Theme.of(context).colorScheme.primary),
                      SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Confirm new pin",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      PinCodeTextField(
                          controller: _confirmNewPin,
                          pinBoxWidth: 45,
                          pinBoxHeight: 50,
                          pinTextStyle: TextStyle(
                              fontSize: 18,
                              color: Theme.of(context).colorScheme.primary),
                          onDone: (text) {},
                          highlight: true,
                          highlightColor: Theme.of(context).colorScheme.primary,
                          //highlightPinBoxColor:
                          //Theme.of(context).colorScheme.onSurface,
                          maxLength: 4,
                          hasUnderline: false,
                          pinBoxColor: Theme.of(context).cardTheme.color,
                          defaultBorderColor:
                              Theme.of(context).colorScheme.onSurface,
                          pinBoxRadius: 10.0,
                          hasTextBorderColor:
                              Theme.of(context).colorScheme.primary),
                      SizedBox(height: 30),
                      RaisedButton(
                        child: Text("Update"),
                        onPressed: () {
                          if (_oldPinCode.text == userBox.get('pincode') &&
                              _newPinCode.text == _confirmNewPin.text) {
                            userBox.put('pincode', _confirmNewPin.text);
                            final snackBar = SnackBar(
                              content: Text('Pin code has been changed'),
                            );
                            Navigator.of(context).pop();
                            Future.delayed(Duration(milliseconds: 300), () {
                              Scaffold.of(context).showSnackBar(snackBar);
                            });
                          }
                          ;
                        },
                      )
                    ],
                  ),
                ),
              ),
            );
          });
          //_scaffoldKey.currentState.openEndDrawer();
          Scaffold.of(context).openEndDrawer();
        }),
      ],
    );
  }

  Widget _helpAndInfo() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Align(
          child: Text(
            "Help and Info",
            style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 14,
                fontWeight: FontWeight.w700),
          ),
          alignment: Alignment.center),
      Container(
          height: 40,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              "App Version",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
            ),
            Text(
              version,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
            )
          ])),
      SettingEntry("Revisit introduction", () {
        Navigator.pushNamed(context, Routes.onBoardingView);
      }),
      SettingEntry("Submit an issue/feedback", () {
        //launch("TODO: Google forms link");
      }),
      SettingEntry("Security info", () async {
        if (pubKey == "") await getPubKey();
        await showDialog<void>(
            context: context,
            builder: (BuildContext context) {
              return _securityDialog();
            });
      })
    ]);
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
                fontWeight: FontWeight.w700),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          SignInButtonBuilder(
            text: "Join our Discord",
            image:
                SvgPicture.asset("assets/graphics/discord-logo.svg", width: 20),
            iconColor: Colors.white,
            onPressed: () {
              launch("https://discord.io/FluxParty");
            },
            backgroundColor: Color.fromRGBO(114, 137, 218, 1),
          ),
          SizedBox(height: 10),
          SignInButton(Buttons.FacebookNew, text: "Like us on Facebook",
              onPressed: () {
            launch("https://www.facebook.com/VoteFlux.org");
          }),
          SizedBox(height: 10),
          SignInButton(
            Buttons.Twitter,
            text: "Follow our Twitter",
            onPressed: () {
              launch("https://twitter.com/voteflux");
            },
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
        ]);
  }

  Widget _signout() {
    return MaterialButton(
      minWidth: 100,
      height: 30,
      padding: EdgeInsets.symmetric(vertical: 5),
      color: Theme.of(context).colorScheme.secondary,
      onPressed: () {
        Navigator.pushNamedAndRemoveUntil(
            context, Routes.startupView, (r) => false);
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
      onPressed: () {
        func();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 14,
                fontWeight: FontWeight.w400),
          ),
          Icon(Icons.arrow_forward_ios_rounded,
              color: Theme.of(context).colorScheme.primary, size: 16),
        ],
      ),
    );
  }

  Widget _securityDialog() {
    return SimpleDialog(
        backgroundColor: Theme.of(context).backgroundColor,
        title: Align(
          alignment: Alignment.center,
          child: Text(
            'Public Key',
            style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 14,
                fontWeight: FontWeight.w700),
          ),
        ),
        children: <Widget>[
          Padding(
              padding: EdgeInsets.all(20),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  pubKey,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              )),
          IconButton(
              icon: Icon(Icons.copy),
              onPressed: () {
                Clipboard.setData(ClipboardData(text: pubKey));
              })
        ]);
  }
}
