import 'package:flutter/material.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:voting_app/core/enums/viewstate.dart';
import 'package:voting_app/core/router.gr.dart';
import 'package:voting_app/core/viewmodels/user_model.dart';

import '../base_view.dart';

class Signin extends StatelessWidget {
  final TextEditingController _userName = TextEditingController();
  final TextEditingController _pinCode = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BaseView<UserModel>(
      onModelReady: (model) {},
      builder: (context, model, child) => MaterialApp(
        home: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            //remove the tiny gap between appbar and body
            elevation: 0,
            backgroundColor: Theme.of(context).backgroundColor,
          ),
          body: Card(
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
            pinTextStyle: Theme.of(context).textTheme.headline5,
            onDone: (text) {
              print(text);
            },
            highlight: true,
            highlightColor: Theme.of(context).primaryColor,
            highlightPinBoxColor: Theme.of(context).colorScheme.primaryVariant,
            maxLength: 4,
            hasUnderline: false,
            pinBoxColor: Theme.of(context).colorScheme.primaryVariant,
            defaultBorderColor: Theme.of(context).colorScheme.primaryVariant,
            pinBoxRadius: 10.0,
          )
        ],
      ),
    );
  }

  Widget _username(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 40.0),
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
          TextFormField(
            validator: (text) {
              RegExp exp = RegExp(r"[^0-9a-zA-Z]");
              if (text.length < 2 || text.length > 50)
                return 'The length must be between 2 and 50';
              else if (exp.allMatches(text).length != 0)
                return 'No special charactors allowed';
              return null;
            },
            style: Theme.of(context).textTheme.headline6,
            controller: _userName,
            decoration: InputDecoration(
              fillColor: Theme.of(context).colorScheme.primaryVariant,
              filled: true,
              labelText: "username",
              labelStyle: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontStyle: FontStyle.italic,
                  fontSize: 20),
              hintText: 'between 2-50 charactors',
              hintStyle:
                  TextStyle(color: Theme.of(context).colorScheme.onSurface),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          )
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
                    if (_formKey.currentState.validate()) {
                      debugPrint(_userName.text);
                      debugPrint(_pinCode.text);
                      //Todo: register the user
                      await model.create(_userName.text);
                      await Future.delayed(Duration(seconds: 2), () {});
                    }

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
}
