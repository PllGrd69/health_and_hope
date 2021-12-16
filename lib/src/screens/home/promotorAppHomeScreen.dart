import 'package:flutter/material.dart';
import 'package:health_and_hope/src/screens/departamento/misDepartamentosPatrocinador.dart';
import 'package:health_and_hope/src/utils/responsive.dart';

class PatrocinadorAppScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(responsive.ip(3)),
        child: Column(
          children: [
            MisDepartamentosPatrocinador(),
          ],
        ),
      ),
    );
  }
}

