import 'package:flutter/cupertino.dart';

class HelpersAppsColors {

  static final HelpersAppsColors _instancia = HelpersAppsColors._();
  HelpersAppsColors._();

  factory HelpersAppsColors(){
    return _instancia;
  }

  Color _colorBase = Color(0xff21899A);

  // initColors() {
  // }

  Color get colorBase => _colorBase;


}