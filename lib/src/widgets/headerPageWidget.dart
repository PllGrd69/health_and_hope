import 'package:flutter/material.dart';
import 'package:health_and_hope/src/utils/helpers.dart';
import 'package:health_and_hope/src/utils/responsive.dart';


class HeaderPageWidget extends StatelessWidget {

  Color? color;
  final Widget child;

  HeaderPageWidget({this.color, required this.child}){
    if (this.color==null) this.color = HelpersAppsColors().colorBase;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _HeaderWidget(color: color!),
        Container(
          child: child,
        ),
      ],
    );
  }
}


class _HeaderWidget extends StatelessWidget {
  final Color color;
  const _HeaderWidget({required this.color});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    return Container(
      height: responsive.ip(25),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(responsive.ip(3.0)),
          bottomRight: Radius.circular(responsive.ip(3.0))
        )
      ),
    );
  }
}
