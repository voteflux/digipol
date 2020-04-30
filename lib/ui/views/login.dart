import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:voting_app/core/enums/viewstate.dart';
import 'package:voting_app/core/viewmodels/user_model.dart';
import 'package:voting_app/ui/views/base_view.dart';
import 'package:voting_app/ui/widgets/custom_form_feild_widget.dart';
import 'package:voting_app/ui/styles.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

final _formKey = GlobalKey<FormState>();
final Map<String, dynamic> formData = {'name': null};
String _name;

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {

    return BaseView<UserModel>(
      onModelReady: (model) => model.login(),
      builder: (context, model, child) => Scaffold(
        body: Center(
          child: model.state == ViewState.Busy
              ? CircularProgressIndicator()
              : Form(
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
                            validation: (String value) {
                              if (!RegExp(
                                      r"([a-zA-Z]{3,30}\s*)+")
                                  .hasMatch(value)) {
                                return 'Please enter your name';
                              }
                            }),
                        _buildSubmitButton(model)
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildSubmitButton(model) {

    return RaisedButton(
      onPressed: () {
        _submitForm(model);
      },
      child: model.state == ViewState.Busy
          ? CircularProgressIndicator()
          : Text('Login'),
    );
  }

  void _submitForm(model) {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      model.create(_name);
      if (true) {
        Navigator.pushNamed(context, '/');
      }

      print(_name);
    }
  }
}
