import 'package:flutter/material.dart';
import 'package:health_and_hope/src/utils/responsive.dart';


class GestionUsuarioBaseWidget extends StatelessWidget {
  const GestionUsuarioBaseWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    return Container(
      height: responsive.height,
      width: responsive.width,
      color: Colors.orange,
    );
  }
}
