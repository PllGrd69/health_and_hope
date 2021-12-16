import 'package:flutter/material.dart';
import 'package:health_and_hope/src/utils/helpers.dart';
import 'package:reactive_forms/reactive_forms.dart';



class DropdownFieldCustomWidget extends StatelessWidget {
  final String formControlTextName;
  final IconData? icon;
  final Function onChanged;
  final Map<String, String> validationMessages;
  final String labelText;
  final Widget? hint;
  final List<DropdownMenuItem<dynamic>> items;

  const DropdownFieldCustomWidget({
    this.icon,
    required this.onChanged,
    required this.formControlTextName,
    required this.validationMessages,
    required this.labelText,
    this.hint,
    required this.items
  });

  @override
  Widget build(BuildContext context) {
    final decoration = InputDecoration(
      labelStyle: TextStyle(
        color: HelpersAppsColors().colorBase,
      ),
      hintStyle: TextStyle(
          color: Colors.grey
      ),
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


    final dropdownField = ReactiveDropdownField<dynamic>(
      isExpanded: true,
      formControlName: formControlTextName,

      hint: hint,
      items: items,
      onChanged: (_){
        FocusScope.of(context).unfocus();
        onChanged();
      },
      validationMessages: (control) => validationMessages,
      decoration: (icon!=null)?decoration.copyWith(prefixIcon: Icon( icon, color: HelpersAppsColors().colorBase)): decoration,
    );

    return Padding(
        padding: EdgeInsets.symmetric(vertical: 5),
        child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: dropdownField
        )
    );
  }
}