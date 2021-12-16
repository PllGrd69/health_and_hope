import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_and_hope/src/utils/helpers.dart';
import 'package:reactive_forms/reactive_forms.dart';

class RoundedPasswordField extends StatefulWidget {
  final String formControlTextName;
  final Map<String, String> validationMessages;
  final String hintText;
  final String labelText;
  const RoundedPasswordField({
    Key? key,
    required this.formControlTextName,
    required this.validationMessages,
    required this.hintText,
    required this.labelText,
  }) : super(key: key);

  @override
  _RoundedPasswordFieldState createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    final textField = ReactiveTextField(
      keyboardType: TextInputType.text,
      obscureText: !isVisible,
      textInputAction: TextInputAction.next,
      formControlName: widget.formControlTextName,
      validationMessages: (control) => widget.validationMessages,
      decoration: InputDecoration(
        labelStyle: TextStyle(
          color: HelpersAppsColors().colorBase,
        ),
        hintStyle: TextStyle(
            color: Colors.grey
        ),

        hintText: widget.hintText,
        labelText: widget.labelText,
        border: OutlineInputBorder(
          // borderRadius: BorderRadius.circular(30),
          gapPadding: 2
        ),

        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: HelpersAppsColors().colorBase,
            width: 2
          ),
          // borderRadius: BorderRadius.circular(30),
        ),
        prefixIcon: Icon(
          FontAwesomeIcons.lock,
          color: HelpersAppsColors().colorBase,
        ),
        suffixIcon: GestureDetector(
          onTap: () => setState(() => this.isVisible=!this.isVisible),
          child: Icon(
            (isVisible)? FontAwesomeIcons.eyeSlash:FontAwesomeIcons.eye,
            color: HelpersAppsColors().colorBase,
          ),
        ),
          // border: InputBorder.none,
      ),
    );

    return Padding(padding: EdgeInsets.symmetric(vertical: 5),child: textField);
  }
}