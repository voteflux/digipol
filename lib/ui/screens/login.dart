import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:voting_app/ui/widgets/custom_widgets.dart';
import 'package:voting_app/ui/styles.dart';
import 'package:voting_app/ui/screens/login/signup.dart';
import 'package:provider/provider.dart';
import 'package:voting_app/core/services/auth/user_auth.dart';


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
      body: (Center(
        child: Container(
          width: appSizes.mediumWidth,
          child: LogIn(),
        ),
      )),
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
    'name': null
  };
  String _name;

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
                "Register to vote",
                style: appTextStyles.heading,
              ),
            ),
            CustomFormField(
                helpText: "Your name",
                submitAction: (String value) {
                   _name = value;
                },),
            _buildSubmitButton(),
            new Divider(
              color: appColors.text,
            )
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
      child: Text('Register'),
    );
  }
  void _submitForm() {
    print("Fix errors");
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      Provider.of<UserRepository>(context,listen: false).signIn(_name);
      print(_name);
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
