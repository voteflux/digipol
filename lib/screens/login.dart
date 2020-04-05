import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:voting_app/widgets/custom_widgets.dart';
import 'package:voting_app/styles.dart';
import 'package:voting_app/screens/login/signup.dart';

class ProfilePage extends StatefulWidget {

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  //  Need a method to show we are logged in. json file?
  bool loggedIn = false;
  bool login = false;

  @override
  Widget build(BuildContext context) {
    // this is where we choose what to show on this page
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: appColors.background,
      body: LogIn()
    );
  }
}

class LogIn extends StatefulWidget {
  @override
  _LogInWidgetState createState() => _LogInWidgetState();
}

class _LogInWidgetState extends State<LogIn> {

  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> formData = {
    'email': null,
    'password': null
  };

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Text(
                "Log In",
                style: appTextStyles.heading,
              ),
            ),
            CustomFormField(
                helpText: "Email",
                submitAction: (String value) {
                  formData['email'] = value;
                },
                validation: (String value) {
                  if (!RegExp(
                          r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                      .hasMatch(value)) {
                    return 'This is not a valid email';
                  }
                }),
            CustomFormField(
                helpText: "Password",
                submitAction: (String value) {
                  formData['password'] = value;
                },
                validation: (String value) {
                  if (value.isEmpty) {
                    return 'Enter a password';
                  }
                }),
            _buildSubmitButton(),
            new Divider(
              color: appColors.text,
            ),
            _buildSignUpButton()
          ],
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return RaisedButton(
      onPressed: () {
        _submitForm();
      },
      child: Text('Login'),
    );
  }

  Widget _buildSignUpButton() {
    return RaisedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SignUpPage()),
        );
      },
      child: Text('Sign Up Now'),
    );
  }

  void _submitForm() {
    print("Fix errors");
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save(); //onSaved is called!
      print(formData);
    }
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
