import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_and_hope/src/bloc/bloc.dart';
import 'package:health_and_hope/src/screens/departamento/departamentoScreen.dart';
import 'package:health_and_hope/src/screens/gestionUsuario/gestionUsuarioScreen.dart';
import 'package:health_and_hope/src/utils/responsive.dart';
import 'package:health_and_hope/src/widgets/buttonCustom.dart';


class AminAppHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(responsive.ip(3)),
        child: Column(
          children: [
            _GesionarUsuariosButton(),
            _GesionarAppButton(),
          ],
        ),
      ),
    );
  }
}

class _GesionarUsuariosButton extends StatelessWidget {
  Widget _buttonModel(BuildContext context, Responsive responsive) {
    return Container(
      padding: EdgeInsets.only(bottom: responsive.ip(1)),
      width: responsive.ip(70),
      child: ButtonActionWidget(
        padding: EdgeInsets.symmetric(horizontal: responsive.ip(1.5), vertical: responsive.ip(1.5)),
        text: 'Gestionar Usuarios',
        onPressed: () => onPressed(context),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    return _buttonModel(context, responsive);
  }

  void onPressed (BuildContext context) {
    Navigator.pushNamed(context, GestionUsuariosScreen.routeName);
  }
}

class _GesionarAppButton extends StatelessWidget {
  Widget _buttonModel(BuildContext context, Responsive responsive) {
    return Container(
      padding: EdgeInsets.only(bottom: responsive.ip(1)),
      width: responsive.ip(70),
      child: ButtonActionWidget(
        padding: EdgeInsets.symmetric(horizontal: responsive.ip(1.5), vertical: responsive.ip(1.5)),
        text: 'Gestionar Departamentos',
        onPressed: () => onPressed(context),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    return _buttonModel(context, responsive);
  }

  void onPressed (BuildContext context) {
    Navigator.pushNamed(context, DepartamentosScreen.routeName);
  }
}