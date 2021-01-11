import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:voting_app/core/enums/viewstate.dart';
import 'package:voting_app/core/viewmodels/user_model.dart';
import 'package:voting_app/ui/styles.dart';
import 'package:voting_app/ui/views/base_view.dart';
import 'package:voting_app/ui/widgets/custom_form_feild_widget.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:voting_app/core/enums/viewstate.dart';
import 'package:voting_app/core/router.gr.dart';
import 'package:voting_app/core/viewmodels/user_model.dart';

import '../../core/router.gr.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

final TextEditingController _userName = TextEditingController();
final TextEditingController _pinCode = TextEditingController();
final _formKey = GlobalKey<FormState>();
final Map<String, String> formData = {"name": ""};
// TODO: this should not be a global variable! -MK
String _name = "";

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return BaseView<UserModel>(
      onModelReady: (model) => model.login(),
      builder: (context, model, child) => Scaffold(
        body: Center(
          child: model.state == ViewState.Busy
              ? CircularProgressIndicator()
              : Card(
                  color: Theme.of(context).backgroundColor,
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Center(
                        child: Column(
                          children: [
                            _logo(),
                            _username(context),
                            _pincode(context),
                            _submit(context, model),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  Widget _logo() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30.0),
      child: Image(
          width: 90.0,
          height: 90.0,
          image: NetworkImage(
              'https://user-images.githubusercontent.com/68624164/92993763-9fba1400-f537-11ea-8403-808759f998c6.png')),
    );
  }

  Widget _pincode(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 40.0),
      child: Column(
        children: [
          Text(
            'Choose a pin',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          PinCodeTextField(
            controller: _pinCode,
            pinBoxWidth: 45,
            pinBoxHeight: 50,
            pinTextStyle:
                TextStyle(color: Theme.of(context).colorScheme.onSurface),
            onDone: (text) {
              print(text);
            },
            highlight: true,
            highlightColor: Theme.of(context).primaryColor,
            highlightPinBoxColor: Theme.of(context).backgroundColor,
            maxLength: 4,
            hasUnderline: false,
            pinBoxColor: Theme.of(context).backgroundColor,
            defaultBorderColor: Theme.of(context).colorScheme.onSurface,
            pinBoxRadius: 10.0,
          )
        ],
      ),
    );
  }

  Widget _username(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
      child: Column(
        children: [
          Text(
            'Choose a name',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          CustomFormField(
              helpText: "Your name",
              submitAction: (String value) {
                _name = value;
              },
              validation: (String value) {
                if (!RegExp(r"([a-zA-Z]{3,30}\s*)+").hasMatch(value)) {
                  return 'Please enter your name';
                }
                return null;
              }),
        ],
      ),
    );
  }

  Widget _submit(BuildContext context, UserModel model) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        children: [
          model.state == ViewState.Idle
              ? RaisedButton(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  color: Theme.of(context).primaryColor,
                  onPressed: () async {
                    model.setState(ViewState.Busy);
                    //check validator and register the user

                    await _submitForm(model);

                    model.setState(ViewState.Idle);
                    //Todo: redirect to onboarding page
                  },
                  child: Text(
                    'Create login',
                    style: TextStyle(fontSize: 18),
                  ),
                )
              : CircularProgressIndicator(),
          SizedBox(height: 130.0),
          FlatButton(
            onPressed: () {
              //Todo: redirect to signin page
              Navigator.pushNamed(context, Routes.profilePage);
            },
            child: Text(
              'Already a user? Log in',
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 18.0,
              ),
            ),
          )
        ],
      ),
    );
  }

  void _submitForm(UserModel model) {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      model.create(_name);
      // redirect to OnBoarding page
      // TODO: will change it later - Meena
      Navigator.pushNamed(context, Routes.onBoardingView);
      // Navigator.pushNamed(context, '/');
    }
  }
}
