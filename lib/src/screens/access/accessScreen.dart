import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_and_hope/src/bloc/bloc.dart';
import 'package:health_and_hope/src/screens/calendario/calendarioParticpanteScreen.dart';
import 'package:health_and_hope/src/screens/perfilUser.dart';
import 'package:health_and_hope/src/screens/home/homeScreen.dart';
import 'package:health_and_hope/src/screens/login_screen.dart';
import 'package:health_and_hope/src/utils/textFontStyle.dart';
import 'package:health_and_hope/src/utils/userRole.dart';
import 'package:health_and_hope/src/widgets/navigationBarWidget.dart';

class AccessScreen extends StatelessWidget {
  static final routeName = 'accessScreen';
  const AccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _currentUser(context);
    return BlocBuilder<UserAppBloc, UserAppState>(
      builder: (context, state) {
        if (state.userAccess==null) return Container();

        if (state.userAccess!.rol == RoleUser.participante) {
          return _AccesScreenParticipante();
        } else if (state.userAccess!.rol == RoleUser.admin_app) {
          return _AccesScreenAdmin();
        } else if (state.userAccess!.rol == RoleUser.personal) {
          return _AccesScreenParsonal();
        }
        return Container();
      }
    );

  }

  _currentUser(BuildContext context){
    final state = BlocProvider.of<UserAppBloc>(context, listen: true).state;
    Future.microtask(() {
      if (state.errorsLogin != null && state.userAccess == null) {
        print("-------------------1------------------------");

        Navigator.pushNamedAndRemoveUntil(
          context,
          LoginScreen.routeName,
          (Route<dynamic> route) => false
        );
      } else if(state.userAccess == null){
        print("------------------2-------------------------");
        Navigator.pushNamedAndRemoveUntil(
            context,
            LoginScreen.routeName,
                (Route<dynamic> route) => false
        );
      }
    });
  }


}

class _AccesScreenParsonal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NavigationBarWidgets(
      itemsNavigation: [
        TabItem(icon: FontAwesomeIcons.calendar),
        TabItem(icon: Icons.play_arrow_rounded),
        TabItem(icon: FontAwesomeIcons.user),
      ],
      children: [
        CalendarioParticipanteScreen(),
        HomeScreen(),
        PerfilUsuarioApp(),
      ],
      initialPage: 1,
    );
  }
}

class _AccesScreenAdmin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NavigationBarWidgets(
      itemsNavigation: [
        TabItem(icon: FontAwesomeIcons.calendar),
        TabItem(icon: Icons.play_arrow_rounded),
        TabItem(icon: FontAwesomeIcons.user),
      ],
      children: [
        CalendarioParticipanteScreen(),
        HomeScreen(),
        PerfilUsuarioApp(),
      ],
      initialPage: 1,
    );
  }
}

class _AccesScreenParticipante extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NavigationBarWidgets(
      itemsNavigation: [
        TabItem(icon: FontAwesomeIcons.calendar),
        TabItem(icon: Icons.play_arrow_rounded),
        TabItem(icon: FontAwesomeIcons.user),
      ],
      children: [
        CalendarioParticipanteScreen(),
        HomeScreen(),
        PerfilUsuarioApp(),
      ],
      initialPage: 1,
    );
  }
}

class Calendario extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final fontStyle = TextFontStyle.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(width: double.infinity),
        Text('NUMERO uno', style: fontStyle.title1),
        Text('NUMERO uno', style: fontStyle.title2),
        Text('NUMERO uno', style: fontStyle.subtitle1),
        Text('NUMERO uno', style: fontStyle.subtitle2),
        Text('NUMERO uno', style: fontStyle.normalText1),
        Text('NUMERO uno', style: fontStyle.normalText2),
      ],
    );
  }
}
