import 'package:flutter/material.dart';
import 'package:health_and_hope/src/utils/helpers.dart';
import 'package:health_and_hope/src/utils/responsive.dart';



class ButtonActionWidget extends StatelessWidget {
  final String text;
  VoidCallback? onPressed;
  final Alignment alignment;
  final EdgeInsetsGeometry padding;
  ButtonActionWidget({
    required this.text,
    this.onPressed,
    this.alignment = Alignment.center,
    this.padding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        alignment: alignment,
        backgroundColor: onPressed!=null?
        MaterialStateProperty.all(HelpersAppsColors().colorBase)
        :
        MaterialStateProperty.all(HelpersAppsColors().colorBase.withOpacity(0.7)),
      ),
      child: Container(
        child: Text(
          text,
          style: Theme.of(context).textTheme.button?.copyWith(
            color: Colors.white,
            fontSize: responsive.ip(1.7),
          ),
          textAlign: TextAlign.center,
        ),
        padding: padding,
      ),
    );
  }

}