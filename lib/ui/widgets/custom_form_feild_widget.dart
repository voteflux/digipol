import 'package:flutter/material.dart';
import 'package:voting_app/ui/styles.dart';

class CustomFormField extends StatelessWidget {
  final String helpText;
  final void Function(String) submitAction;
  final String /*?*/ Function(String) /*?*/ validation;
  final String initialTextValue;

  CustomFormField(
      {@required this.helpText,
      @required this.submitAction,
      this.validation,
      this.initialTextValue = ""});

  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.0),
      child: TextFormField(
          decoration: InputDecoration(
            filled: true,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              borderSide: BorderSide(
                  width: 2, color: Theme.of(context).colorScheme.primary),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              borderSide: BorderSide(width: 2, color: Colors.orange),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              borderSide: BorderSide(width: 2, color: appColors.text),
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                borderSide: BorderSide(
                  width: 2,
                )),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                borderSide: BorderSide(width: 2, color: Colors.red)),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                borderSide: BorderSide(width: 2, color: Colors.yellowAccent)),
            labelText: this.helpText,
            labelStyle: TextStyle(
                color: Theme.of(context).colorScheme.onSurface, fontSize: 16.0),
          ),
          onSaved: this.submitAction,
          validator: this.validation,
          initialValue: this.initialTextValue),
    );
  }
}
