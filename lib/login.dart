import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:voting_app/custom_widgets.dart';
import 'package:voting_app/styles.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  //  Need a method to show we are logged in. json file?
  bool loggedIn = false;
  bool login = false;
  Widget show = LoginWidget();

  @override
  Widget build(BuildContext context) {
    // this is where we choose what to show on this page
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: appColors.background,
      body: loggedIn ? ProfileWidget() : LoginWidget(),
    );
  }

    Widget _buildLoginButton() {
    return RaisedButton(
      onPressed: () {
        this.login =! this.login;
      },
      child: Text('Login'),
    );
  }
}

class LoginWidget extends StatefulWidget {
  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {

  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> formData = {
    'first_name': null,
    'other_given_names': null,
    'family_name': null,
    'email': null,
    'post_code': null,
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
                "Your Profile",
                style: appTextStyles.standard,
              ),
            ),
            CustomFormField(
              helpText: "First Name",
              submitAction: (String value) {
                formData['first_name'] = value;
              },
            ),
            CustomFormField(
              helpText: "Other Given Names",
              submitAction: (String value) {
                formData['other_given_names'] = value;
              },
            ),
            CustomFormField(
              helpText: "Family Name",
              submitAction: (String value) {
                formData['family_name'] = value;
              },
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
              helpText: "Post Code",
              submitAction: (String value) {
                formData['post_code'] = value;
              },
            ),
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
            _buildSubmitButton()
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
      child: Text('Sign Up'),
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
