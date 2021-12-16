import 'package:flutter/widgets.dart';
import 'dart:math' as math;
class Responsive {
  final double width, height, inch;

  Responsive({required this.width, required this.height, required this.inch});

  factory Responsive.of(BuildContext context) {
    final MediaQueryData data = MediaQuery.of(context);
    final size = data.size;

    // Pitagoras -> c2 = a2+b2 -> sqrt(a^2, b^2)
    final inch = math.sqrt(math.pow(size.width, 2) + math.pow(size.height, 2));
    return Responsive(width: size.width, height: size.height, inch: inch);
  }
  double wp(double porcent) => this.width * (porcent/100);
  double hp(double porcent) => this.height * (porcent/100);
  double ip (double porcent) => this.inch * (porcent/100);
}