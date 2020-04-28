import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:voting_app/core/enums/viewstate.dart';
import 'package:voting_app/core/viewmodels/user_model.dart';
import 'package:voting_app/ui/views/base_view.dart';
import 'package:voting_app/core/models/user.dart';
import 'package:voting_app/ui/widgets/custom_form_feild_widget.dart';
import 'package:voting_app/ui/styles.dart';
import 'package:voting_app/ui/views/login/signup.dart';
import 'package:provider/provider.dart';
import 'package:voting_app/core/enums/authstate.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return BaseView<UserModel>(
      onModelReady: (model) => model.login(),
      builder: (context, model, child) => Scaffold(
        body: Center(
          child: model.state == ViewState.Busy
              ? CircularProgressIndicator()
              : LogIn(),
        ),
      ),
    );
  }
}

class LogIn extends StatefulWidget {
  @override
  _LogInWidgetState createState() => _LogInWidgetState();
}

class _LogInWidgetState extends State<LogIn> {

  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> formData = {'name': null};
  String _name;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        width: appSizes.mediumWidth,
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Text(
                "Register to vote",
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            CustomFormField(
              helpText: "Your name",
              submitAction: (String value) {
                _name = value;
              },
            ),
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
      child: Text('Register'),
    );
  }

  void _submitForm() async {
    if (_formKey.currentState.validate()) {
      
      _formKey.currentState.save();
      var loginSuccess = await Provider.of<UserModel>(context, listen: false).create(_name);
      if(true) {
        Navigator.pushNamed(context, '/');
      }

      print(_name);
    }
  }
}
