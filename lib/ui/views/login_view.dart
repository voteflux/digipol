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
// TODO: this should not be a global variable! -MK

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return BaseView<UserModel>(
      onModelReady: (model) => model.login(),
      builder: (context, model, child) => Scaffold(
        body: Center(
          child: model.state == ViewState.Busy
              ? CircularProgressIndicator()
              : SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: ListBody(
                      children: [
                        _logo(),
                        _username(context, model),
                        _pincode(context, model),
                        _submit(context, model),
                        FlatButton(
                          onPressed: () {
                            //Todo: redirect to signin page
                            Navigator.pushNamed(context, Routes.profilePage);
                          },
                          child: Text(
                            'Already a user? Log in',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: 14.0,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  Widget _logo() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.0),
      child: Image(
          width: 150.0,
          height: 150.0,
          image: NetworkImage(
              'https://digipol.app/wp-content/uploads/2020/11/digipol-logo.png')),
    );
  }

  Widget _pincode(BuildContext context, UserModel model) {
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
            onDone: (code) {
              model.pincode = code;
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

  Widget _username(BuildContext context, UserModel model) {
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
                model.user = value;
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
                    await _submitForm(model);
                  },
                  child: Text(
                    'Create login',
                    style: TextStyle(fontSize: 18),
                  ),
                )
              : CircularProgressIndicator(),
        ],
      ),
    );
  }

  void _submitForm(UserModel model) {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      model.create(model.user, model.pincode);
      // redirect to OnBoarding page
      // TODO: will change it later - Meena
      Navigator.pushNamed(context, Routes.onBoardingView);
      // Navigator.pushNamed(context, '/');
    }
  }
}
