import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:voting_app/ui/widgets/custom_widgets.dart';
import 'package:voting_app/ui/styles.dart';
import 'package:voting_app/ui/views/login.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  //  Need a method to show we are logged in. json file?

  @override
  Widget build(BuildContext context) {
    // this is where we choose what to show on this page
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: appColors.background,
      body: (Center(
        child: Container(
          width: appSizes.mediumWidth,
          child: SignUp(),
        ),
      )),
    );
  }
}

class SignUp extends StatefulWidget {
  @override
  _SignUpWidgetState createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUp> {
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
                "Sign up",
                style: appTextStyles.heading,
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
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save(); //onSaved is called!
      print(formData);
    }
  }
}
