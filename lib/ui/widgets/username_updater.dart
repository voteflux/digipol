import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:voting_app/core/consts.dart';

class UsernameUpdater extends StatefulWidget {
  @override
  _UsernameUpdaterState createState() => _UsernameUpdaterState();
}

class _UsernameUpdaterState extends State<UsernameUpdater> {
  final TextEditingController _userName = TextEditingController();
  final TextEditingController _pinCode = TextEditingController();
  Box userBox = Hive.box<String>(HIVE_USER_PREFS_STR);
  bool hasError = false;
  String errorMsg = '';

  @override
  Widget build(BuildContext context) {
    return Container(
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
              backgroundColor: Theme.of(context).colorScheme.secondary,
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
                    fontSize: 18, color: Theme.of(context).colorScheme.primary),
                onDone: (text) {
                  if (text != userBox.get('pincode')) {
                    setState(() {
                      hasError = true;
                      errorMsg = 'Wrong PIN';
                    });
                  } else {
                    setState(() {
                      hasError = false;
                      errorMsg = '';
                    });
                  }
                },
                highlight: true,
                highlightColor: Theme.of(context).colorScheme.primary,
                //highlightPinBoxColor:
                //Theme.of(context).colorScheme.onSurface,
                maxLength: 4,
                hasUnderline: false,
                hasError: hasError,
                pinBoxColor: Theme.of(context).cardTheme.color,
                defaultBorderColor: Theme.of(context).colorScheme.onSurface,
                pinBoxRadius: 10.0,
                hasTextBorderColor: Theme.of(context).colorScheme.primary),
            SizedBox(height: 20),
            Visibility(
              child: Text(errorMsg,
                  style: TextStyle(color: Colors.redAccent),
                  textAlign: TextAlign.center),
              visible: hasError,
            ),
            SizedBox(height: 30),
            RaisedButton(
              child: Text(
                "Update",
              ),
              onPressed: () {
                RegExp exp = RegExp(r"[^0-9a-zA-Z]");
                if (_userName.text.length < 2 || _userName.text.length > 50) {
                  setState(() {
                    hasError = true;
                    errorMsg =
                        'The length of Username must be between 2 and 50';
                  });
                } else if (exp.allMatches(_userName.text).length != 0)
                  setState(() {
                    hasError = true;
                    errorMsg = 'No special charactors allowed in Username';
                  });
                else
                  setState(() {
                    hasError = false;
                    errorMsg = '';
                  });
                if (!hasError) {
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
    );
  }
}
