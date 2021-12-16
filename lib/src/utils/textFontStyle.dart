import 'package:flutter/material.dart';
import 'package:health_and_hope/src/utils/responsive.dart';

class TextFontStyle {
  TextStyle? _title1, _title2, _subtitle1, _subtitle2, _normalText1, _normalText2;

  TextFontStyle({
    required TextStyle title1,
    required TextStyle title2,
    required TextStyle subtitle1,
    required TextStyle subtitle2,
    required TextStyle normalText1,
    required TextStyle normalText2,
  }){
    this._title1 = title1;
    this._title2 = title2;
    this._subtitle1 = subtitle1;
    this._subtitle2 = subtitle2;
    this._normalText1 = normalText1;
    this._normalText2 = normalText2;
  }

  factory TextFontStyle.of(BuildContext context) {
    final responsive = Responsive.of(context);
    final MediaQueryData data = MediaQuery.of(context);
    final size = data.size;

    return TextFontStyle(
      title1: Theme.of(context)
          .textTheme.bodyText1!.copyWith(fontSize: responsive.ip(4.3)),
      title2: Theme.of(context)
          .textTheme.bodyText1!.copyWith(fontSize: responsive.ip(3.5)),
      normalText1: Theme.of(context)
          .textTheme.bodyText2!.copyWith(fontSize: responsive.ip(2)),
      normalText2: Theme.of(context)
          .textTheme.bodyText2!.copyWith(fontSize: responsive.ip(1.8)),
      subtitle1: Theme.of(context)
          .textTheme.bodyText1!.copyWith(fontSize: responsive.ip(3)),
      subtitle2: Theme.of(context)
          .textTheme.bodyText1!.copyWith(fontSize: responsive.ip(2.5)),
    );
  }

  TextStyle get title1 => this._title1!;
  TextStyle get title2 => this._title2!;
  TextStyle get normalText1 => this._normalText1!;
  TextStyle get normalText2 => this._normalText2!;
  TextStyle get subtitle1 => this._subtitle1!;
  TextStyle get subtitle2 => this._subtitle2!;

}