import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_and_hope/src/bloc/bloc.dart';
import 'package:health_and_hope/src/bloc/screensCustomHelper/screensCustomHelperBloc.dart';
import 'package:health_and_hope/src/models/baseModel/models.dart';
import 'package:health_and_hope/src/models/models/tarjetaModificacionModel.dart';
import 'package:health_and_hope/src/screens/actividad/actividadesScreen.dart';
import 'package:health_and_hope/src/screens/screens.dart';

class AppRouter{
  // final CounterCubit _counterCubit = CounterCubit(); //Si queremos compartir el estado a todos los casos de -> onGenerateRoute
  Route onGenerateRoute(RouteSettings routeSettings){

    if (LoginScreen.routeName == routeSettings.name)
      return MaterialPageRoute(builder: (_)=> LoginScreen());
    else if (HelpScreen.routeName == routeSettings.name) {
      return MaterialPageRoute(builder: (BuildContext context)=> BlocProvider(
        create: (BuildContext context)=> ScreenCustomHelperBloc(),
        child: HelpScreen(),
      ));
    }
    else if (HomeScreen.routeName == routeSettings.name) {
      return MaterialPageRoute(builder: (BuildContext context)=> HomeScreen());
    }
    else if (AccessScreen.routeName == routeSettings.name) {
      return MaterialPageRoute(builder: (BuildContext context)=> AccessScreen());
    }
    else if (ResetPasswordScreen.routeName == routeSettings.name) {
      return MaterialPageRoute(builder: (BuildContext context)=> ResetPasswordScreen());
    }
    else if (ActividadesUsuarioScreen.routeName == routeSettings.name) {
      final args = routeSettings.arguments as TarjetaModificacionModel;
      return MaterialPageRoute(
        builder: (BuildContext context) => ActividadesUsuarioScreen(
          tarjetaModif: args,
        )
      );
    }
    else if (GestionUsuariosScreen.routeName == routeSettings.name) {
      return MaterialPageRoute(builder: (BuildContext context)=> GestionUsuariosScreen());
    }
    else if (RegistrarUsuarioScreen.routeName == routeSettings.name) {
      final args = routeSettings.arguments as String;
      return MaterialPageRoute(builder: (BuildContext context) => RegistrarUsuarioScreen(
        tipoUsuario: args,
      ));
    }
    else if (PersonalDepartamentoScreen.routeName == routeSettings.name) {
      final args = routeSettings.arguments as DepartamentoModel;
      return MaterialPageRoute(builder: (BuildContext context) => PersonalDepartamentoScreen(
        departamento: args,
      ));
    }//
    else if (FormRegistroPersonalDepartScreen.routeName == routeSettings.name) {
      final args = routeSettings.arguments as DepartamentoModel;
      return MaterialPageRoute(builder: (BuildContext context) => FormRegistroPersonalDepartScreen(
        departamento: args,
      ));
    }
    else if (GestionParticipanteScreen.routeName == routeSettings.name) {
      final args = routeSettings.arguments as ParticipanteModel;
      return MaterialPageRoute(builder: (BuildContext context)=> GestionParticipanteScreen(
        participante: args,
      ));
    }
    else if (AgregarAsistentesScreen.routeName == routeSettings.name) {
      final args = routeSettings.arguments as ParticipanteModel;
      return MaterialPageRoute(builder: (BuildContext context)=> AgregarAsistentesScreen(
        participante: args,
      ));
    }
    else if (AgregarPromotoresScreen.routeName == routeSettings.name) {
      final args = routeSettings.arguments as ParticipanteModel;
      return MaterialPageRoute(builder: (BuildContext context)=> AgregarPromotoresScreen(
        participante: args,
      ));
    }
    else if (DepartamentosScreen.routeName == routeSettings.name) {
      return MaterialPageRoute(builder: (BuildContext context)=> DepartamentosScreen());
    }

    else if (TarjetaModificacionRegistroScreen.routeName == routeSettings.name) {
      final args = routeSettings.arguments as ParticipanteModel;
      return MaterialPageRoute(builder: (BuildContext context)=> TarjetaModificacionRegistroScreen(
        participante: args,
      ));
    }

    else if (TarjetaModificacionEditarScreen.routeName == routeSettings.name) {
      final args = routeSettings.arguments as TarjetaModificacionModel;
      return MaterialPageRoute(builder: (BuildContext context)=> TarjetaModificacionEditarScreen(
        tarjetaModificacion: args,
      ));
    }

    else {
      return MaterialPageRoute(
          builder: (_)=> Scaffold(
            body: Center(
              child: Text('Pagina no encontrada'),
            ),
          )
      );
    }

  }

  void dispose(){
    // _counterCubit.close();
  }
}