import 'package:flutter/material.dart';
import 'package:health_and_hope/src/utils/helpers.dart';
import 'package:reactive_forms/reactive_forms.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final String formControlTextName;
  final IconData? icon;
  final Function onSubmitted;
  final Map<String, String> validationMessages;
  final String labelText;
  final TextInputType textInputType;
  final int? minLines;
  final int? maxLines;

  const RoundedInputField({
    Key? key,
    required this.hintText,
    this.icon,
    required this.onSubmitted,
    required this.formControlTextName,
    required this.validationMessages,
    required this.labelText,
    required this.textInputType,
    this.minLines,
    this.maxLines
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final decoration = InputDecoration(
      labelStyle: TextStyle(
        color: HelpersAppsColors().colorBase,
      ),
      hintStyle: TextStyle(
          color: Colors.grey
      ),

      hintText: hintText,
      labelText: labelText,
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

    );
    // TextFieldContainer(
      // child:
    final textField = ReactiveTextField(
      keyboardType: textInputType,
      minLines: minLines,
      maxLines: maxLines,
      formControlName: formControlTextName,
      onSubmitted: () => onSubmitted(),
      textInputAction: TextInputAction.next, // n
      validationMessages: (control) => validationMessages,
      cursorColor: HelpersAppsColors().colorBase,
      decoration: (icon!=null)?decoration.copyWith(
        prefixIcon: Icon(
          icon,
          color: HelpersAppsColors().colorBase,
        )
      ): decoration
    );


    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: SingleChildScrollView(
      scrollDirection: Axis.vertical, child: textField)
    );
  }
}