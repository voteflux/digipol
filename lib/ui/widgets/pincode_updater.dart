import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:voting_app/core/consts.dart';

class PincodeUpdater extends StatefulWidget {
  @override
  _PincodeUpdaterState createState() => _PincodeUpdaterState();
}

class _PincodeUpdaterState extends State<PincodeUpdater> {
  Box userBox = Hive.box<String>(HIVE_USER_PREFS_STR);
  final TextEditingController _oldPinCode = TextEditingController();
  final TextEditingController _newPinCode = TextEditingController();
  final TextEditingController _confirmNewPin = TextEditingController();
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
                    fontSize: 18, color: Theme.of(context).colorScheme.primary),
                onDone: (text) {
                  if (text != userBox.get('pincode')) {
                    setState(() {
                      hasError = true;
                      errorMsg = 'Wrong Pin';
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
                pinBoxColor: Theme.of(context).cardTheme.color,
                defaultBorderColor: Theme.of(context).colorScheme.onSurface,
                pinBoxRadius: 10.0,
                hasTextBorderColor: Theme.of(context).colorScheme.primary),
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
                    fontSize: 18, color: Theme.of(context).colorScheme.primary),
                highlight: true,
                highlightColor: Theme.of(context).colorScheme.primary,
                //highlightPinBoxColor:
                //Theme.of(context).colorScheme.onSurface,
                maxLength: 4,
                hasUnderline: false,
                pinBoxColor: Theme.of(context).cardTheme.color,
                defaultBorderColor: Theme.of(context).colorScheme.onSurface,
                pinBoxRadius: 10.0,
                hasTextBorderColor: Theme.of(context).colorScheme.primary),
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
                    fontSize: 18, color: Theme.of(context).colorScheme.primary),
                onDone: (text) {
                  if (text != _newPinCode.text) {
                    setState(() {
                      hasError = true;
                      errorMsg = 'Password confirmation must match Password';
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
              child: Text("Update"),
              onPressed: () {
                if (_oldPinCode.text == userBox.get('pincode') &&
                    _newPinCode.text == _confirmNewPin.text) {
                  userBox.put('pincode', _confirmNewPin.text);
                  final snackBar = SnackBar(
                    content: Text('Pin code has been changed'),
                  );
                  _oldPinCode.text = '';
                  _newPinCode.text = '';
                  _confirmNewPin.text = '';
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
    );
  }
}
