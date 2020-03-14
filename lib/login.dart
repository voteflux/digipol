import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:voting_app/route_generator.dart';
import 'package:voting_app/styles.dart';
import 'package:flutter_login/flutter_login.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  //  Need a method to show we are logged in. json file?
  bool loggedIn = false;
  Widget show = LoginWidget();

  @override
  Widget build(BuildContext context) {
    // this is where we choose what to show on this page
    if (loggedIn) {
      show = ProfileWidget();
    } else {
      show = LoginWidget();
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColors.mainTheme,
        title: Text('Profile'),
      ),
      backgroundColor: appColors.background,
      body: show,
    );
  }
}

class LoginWidget extends StatefulWidget {
  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'Login',
      onLogin: (_) => Future(null),
      onSignup: (_) => Future(null),
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushNamed(
          '/profile',
        );
      },
      onRecoverPassword: (_) => Future(null),
      theme: LoginTheme(
        primaryColor: appColors.background,
        accentColor: appColors.card,
        errorColor: appColors.card,
        titleStyle: appTextStyles.heading,
        bodyStyle: TextStyle(
          fontStyle: FontStyle.italic,
          decoration: TextDecoration.underline,
        ),
        textFieldStyle: TextStyle(
          color: appColors.button,
          shadows: [Shadow(color: appColors.button, blurRadius: 2)],
        ),
        buttonStyle: appTextStyles.yesnobutton,
        cardTheme: CardTheme(
          color: appColors.card,
          elevation: 5,
          margin: EdgeInsets.only(top: 15),
          shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(100.0)),
        ),
        inputTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey[600],
          contentPadding: EdgeInsets.zero,
          errorStyle: TextStyle(
            backgroundColor: appColors.button,
            color: Colors.black,
          ),
          labelStyle: TextStyle(fontSize: 12),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 4),
//              borderRadius: appSizes.cardCornerRadius,
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 5),
//              borderRadius: inputBorder,
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.deepPurple.shade900, width: 7),
//              borderRadius: inputBorder,
          ),
          focusedErrorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.deepPurple.shade600, width: 8),
//              borderRadius: inputBorder,
          ),
          disabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 5),
//              borderRadius: inputBorder,
          ),
        ),
        buttonTheme: LoginButtonTheme(
          splashColor: Colors.purple,
          backgroundColor: appColors.button,
          highlightColor: Colors.deepPurple,
          elevation: appSizes.cardElevation,
          highlightElevation: 2.0,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: appColors.buttonOutline, width: 2),
            borderRadius: new BorderRadius.circular(appSizes.buttonRadius),
          ),
          // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          // shape: CircleBorder(side: BorderSide(color: Colors.green)),
          // shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(55.0)),
        ),
      ),
    );
  }
}

class ProfileWidget extends StatefulWidget {
  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
