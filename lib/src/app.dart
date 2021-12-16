import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:health_and_hope/src/bloc/bloc.dart';
import 'package:health_and_hope/src/routes/routes.dart';
import 'package:health_and_hope/src/screens/screens.dart';
import 'package:health_and_hope/src/services/service_pages/notificationService.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:health_and_hope/src/utils/helpers.dart';

class AppSaludEsperanza extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => UserAppBloc()),
        BlocProvider(create: (_) => TarjetaModificacionBloc()),
        BlocProvider(create: (_) => ActividadBloc()),
        BlocProvider(create: (_) => ActividadAyudaBloc()),
        BlocProvider(create: (_) => ProgresoActividadBloc()),
        BlocProvider(create: (_) => DepartamentoBloc()),
        BlocProvider(create: (_) => PersonalDepartamentoBloc()),
        BlocProvider(create: (_) => UserBloc()),
        BlocProvider(create: (_) => PersonalBloc()),
        BlocProvider(create: (_) => ParticipanteBloc()),
        BlocProvider(create: (_) => AsistenteBloc()),
        BlocProvider(create: (_) => PromotorBloc()),
      ],
      child: MyApp()
    );
  }
}


class MyApp extends StatelessWidget {
  final AppRouter _appRouter= AppRouter();

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<UserAppBloc>(context, listen: false).add(MyCurrentUserAppEvent());
    return _buildMaterialApp();
  }

  Widget _buildMaterialApp(){
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('es', 'ES'), // Spanish, no country code
      ],
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: LoginScreen.routeName, //Ruta base ************************************
      scaffoldMessengerKey: NotificationService.messengerKey, //Mostrar mensajes
      navigatorObservers: [FlutterSmartDialog.observer], //Mostrar mensajes
      builder: FlutterSmartDialog.init(),
      onGenerateRoute: _appRouter.onGenerateRoute,
      theme: ThemeData.light().copyWith(
      primaryColor: HelpersAppsColors().colorBase
      ),
    );
  }

}