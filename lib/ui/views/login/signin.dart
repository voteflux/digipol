import 'package:flutter/material.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:voting_app/core/enums/viewstate.dart';
import 'package:voting_app/core/viewmodels/base_model.dart';
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
          //appBar: AppBar(
          //backgroundColor: Color(0xff1c1f27),
          //),
          backgroundColor: Color(0xff1c1f27),
          body: Card(
            color: Color(0xff1c1f27),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Center(
                  child: Column(
                    children: [
                      _logo(),
                      _username(),
                      _pincode(),
                      _submit(model),
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
      padding: EdgeInsets.symmetric(vertical: 40.0),
      child: Image(
          width: 90.0,
          height: 90.0,
          image: NetworkImage(
              'https://user-images.githubusercontent.com/68624164/92993763-9fba1400-f537-11ea-8403-808759f998c6.png')),
    );
  }

  Widget _pincode() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 40.0),
      child: Column(
        children: [
          Text(
            'Choose a pin',
            style: TextStyle(
              color: Color(0xff49f2dd),
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
            pinTextStyle: TextStyle(color: Color(0xffababab), fontSize: 20.0),
            onDone: (text) {
              print(text);
            },
            highlight: true,
            highlightColor: Color(0xff49f2dd),
            highlightPinBoxColor: Color(0xff373841),
            maxLength: 4,
            hasUnderline: false,
            pinBoxColor: Color(0xff373841),
            defaultBorderColor: Color(0xff373841),
            pinBoxRadius: 10.0,
          )
        ],
      ),
    );
  }

  Widget _username() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 40.0),
      child: Column(
        children: [
          Text(
            'Choose a name',
            style: TextStyle(
              color: Color(0xff49f2dd),
              fontSize: 15,
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
            style: TextStyle(color: Colors.white),
            controller: _userName,
            decoration: InputDecoration(
              fillColor: Color(0xff373841),
              filled: true,
              labelText: "username",
              labelStyle: TextStyle(
                  color: Color(0xffababab),
                  fontStyle: FontStyle.italic,
                  fontSize: 20),
              hintText: 'between 2-50 charactors',
              hintStyle: TextStyle(color: Color(0xffababab)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _submit(UserModel model) {
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
                  color: Color(0xff49f2dd),
                  onPressed: () async {
                    model.setState(ViewState.Busy);
                    //check validator and register the user
                    if (_formKey.currentState.validate()) {
                      print(_userName.text);
                      print(_pinCode.text);
                      //Todo: register the user
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
          SizedBox(height: 150.0),
          FlatButton(
            onPressed: () {
              //Todo: redirect to signin page
            },
            child: Text(
              'Already a user? Log in',
              style: TextStyle(
                color: Colors.deepPurpleAccent,
                fontSize: 18.0,
              ),
            ),
          )
        ],
      ),
    );
  }
}
