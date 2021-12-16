import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_and_hope/src/bloc/bloc.dart';
import 'package:health_and_hope/src/form_controllers/login_screen_controller.dart';
import 'package:health_and_hope/src/form_controllers/sendEmailResetController.dart';
import 'package:health_and_hope/src/models/baseModel/models.dart';
import 'package:health_and_hope/src/screens/screens.dart';
import 'package:health_and_hope/src/utils/responsive.dart';
import 'package:health_and_hope/src/widgets/buttonCustom.dart';
import 'package:health_and_hope/src/widgets/widgets.dart';
import 'package:reactive_forms/reactive_forms.dart';

class LoginScreen extends StatelessWidget {
  static final String routeName = 'loginScreen';

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    _loadDataMsgServerBackendState(context);
    final containerForm= Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          ReactiveForm(
            formGroup: loginController.loginForm,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: responsive.ip(1.2)),
                _buildTitles(context),
                SizedBox(height: responsive.ip(5)),
                Text('Proceda con su identificación'),
                SizedBox(height: responsive.ip(1.2)),
                _buildEmail(),
                SizedBox(height: responsive.ip(1.2)),
                _buildPassword(),
                SizedBox(height: responsive.ip(4.1)),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _ButtonLogin(),
              SizedBox(height: responsive.ip(1.2)),
              _ButtonResetPassword(),
              // Container(height: 25),
              _RegisterUser(),
            ],
          )
        ],
      ),
    );

    return Scaffold(
        body: CustomAppBarPage(
          children: [
            containerForm
          ],
        )
    );
  }

  Widget _buildTitles(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Inicio de Sesión', style: Theme.of(context).textTheme.headline5!.copyWith(fontSize: 35)),
        Text('Health&Hope', style: Theme.of(context).textTheme.headline6!.copyWith(fontWeight: FontWeight.bold, fontSize: 40) ),
      ],
    );
  }

  Widget _buildEmail(){
    return RoundedInputField (
      formControlTextName: "email",
      textInputType: TextInputType.emailAddress,
      hintText: "example@xd.com",
      icon: FontAwesomeIcons.solidEnvelope,
      labelText: 'Email',
      onSubmitted: () {
        loginController.loginForm.focus('password');
      },
      validationMessages: {
        ValidationMessage.required:'El campo es requerido',
        ValidationMessage.email: 'El email es incorrecto',
      },
    );
  }

  Widget _buildPassword(){
    return RoundedPasswordField(
      formControlTextName: 'password',
      hintText: 'As1Dw@Za2',
      labelText: 'Contraseña',
      validationMessages: {
        ValidationMessage.required:'Este campo es requerido'
      },
    );
  }

  _loadDataMsgServerBackendState(BuildContext context){
    final state = BlocProvider.of<UserAppBloc>(context, listen: true).state;

    print("Login");//Mostrar errores del servidor
    if (state.userAccess!=null){
      print("Usuario");
    }
    if (state.userAccess!=null && state.userAccess!.username!.isNotEmpty){
      print("Aqui-----------");
      loginController.cleanData();
      // BlocProvider.of<ScreenCustomHelperBloc>(context, listen: false).add(AllScreensHelper());
      Future.microtask(() {
        if (state.errorsLogin != null) {
          print("state.errorsLogin != null -> Login Event -----------------------------");
          Navigator.pushNamedAndRemoveUntil(
            context,
            LoginScreen.routeName,
            (Route<dynamic> route) => false
          );
        } else {
          Navigator.pushNamedAndRemoveUntil(
              context,
              AccessScreen.routeName,
              (Route<dynamic> route) => false
          );
        }
      });
    }

    Future.microtask(() {
      if (state.resetPwdStatus == 200 && state.userAccess==null) {
        state.resetPwdStatus=1;
        sendEmailResetPwdController.cleanData();
        Navigator.pushNamedAndRemoveUntil(context, LoginScreen.routeName, (_) => false);
      }
    });

  }

}

class _ButtonResetPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return GestureDetector(
    //   onTap: ()=>Navigator.pushNamed(context, ResetPasswordScreen.routeName),
    //   behavior: HitTestBehavior.translucent,
    //   child: Text('¿OLVIDO SU CONTRASEÑA?')
    // );
    return TextButton(
        onPressed: ()=>Navigator.pushNamed(context, ResetPasswordScreen.routeName),
        child:  Text('¿OLVIDO SU CONTRASEÑA?')
    );

  }
}

class _ButtonLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ButtonActionWidget(
      text: 'Iniciar Sesión',
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      onPressed: ()=> _onPressed(context)
    );
  }
  void _onPressed(BuildContext context) {
    loginController.loginForm.markAllAsTouched();
    FocusScope.of(context).unfocus();
    if (!loginController.loginForm.valid) return;

    final userAppBloc = BlocProvider.of<UserAppBloc>(context, listen: false);
    userAppBloc.add(
        AccessUserApp(accesUserModel: AccesUserModel(
          password: loginController.getPassword,
          email: loginController.getEmail,
        ))
    );
  }
}

class _RegisterUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '¿Nuevo por aquì? ',
            style: Theme.of(context).textTheme.button!.copyWith(fontWeight: FontWeight.normal)
          ),
          // TextSpan(
          //   text: 'Registrate',
          //   recognizer: TapGestureRecognizer()
          //     ..onTap=()=>Navigator.pushNamed(context, RegisterScreen.routeName),
          //   style: Theme.of(context).textTheme.button!.copyWith(
          //     decoration: TextDecoration.underline
          //   )
          // )
        ]
      ),
    );
  }
}





