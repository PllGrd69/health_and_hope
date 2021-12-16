import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_and_hope/src/bloc/bloc.dart';
import 'package:health_and_hope/src/screens/home/adminAppHomeScreen.dart';
import 'package:health_and_hope/src/screens/home/participanteHomeScreen.dart';
import 'package:health_and_hope/src/utils/userRole.dart';


class HomeScreen extends StatelessWidget {
  static final routeName = 'HomeScreen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final stateUser = BlocProvider.of<UserAppBloc>(context, listen: true).state;

    Widget vistaUsuario = Container();
    if (stateUser.userAccess == null) return Scaffold(body: vistaUsuario);
    if (stateUser.userAccess!.rol == null) return Scaffold(body: vistaUsuario);

    if (RoleUser.participante == stateUser.userAccess!.rol!) {
      BlocProvider.of<TarjetaModificacionBloc>(context, listen: false).add(MisTarjetasDeModificacionEvent());
      BlocProvider.of<ProgresoActividadBloc>(context, listen: false).add(MiProgresoActividadEvent());
      vistaUsuario = ParticipanteHomeScreen();
    }

    if (RoleUser.admin_app == stateUser.userAccess!.rol!) {
      BlocProvider.of<DepartamentoBloc>(context, listen: false).add(AllDepartamentos());
      vistaUsuario = AminAppHomeScreen();
    }
    

    return Scaffold(
      body: vistaUsuario,
    );
  }
}






