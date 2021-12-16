import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_and_hope/src/bloc/bloc.dart';
import 'package:health_and_hope/src/form_controllers/sendEmailResetController.dart';
import 'package:health_and_hope/src/utils/helpers.dart';
import 'package:health_and_hope/src/utils/responsive.dart';
import 'package:health_and_hope/src/widgets/buttonCustom.dart';
import 'package:health_and_hope/src/widgets/headerPageWidget.dart';
import 'package:health_and_hope/src/widgets/roundedInputField.dart';
import 'package:health_and_hope/src/widgets/roundedPasswordField.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ResetPasswordScreen extends StatelessWidget {

  static final routeName = 'ResetPasswordScreen';

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    return Scaffold(
      body: HeaderPageWidget(
        child: SingleChildScrollView(
          child: Container(
            width: responsive.width,
            height: responsive.height,
            child: _FormContent(),
          )
        ),
      ),
    );
  }
}

class _FormContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    return Column(
      children: [
        SizedBox(height: responsive.ip(25)),
        _contentForm(context)
      ],
    );
  }

  Widget _contentForm(BuildContext context){
    final responsive = Responsive.of(context);
    return Container(
      margin: EdgeInsets.all(responsive.ip(1)),
      padding: EdgeInsets.all(responsive.ip(2)),
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        children: [
          _FormResetPassword(),
          SizedBox(height: responsive.ip(2)),
          _ButtonResetPwd(),
          SizedBox(height: responsive.ip(1)),
          ButtonActionWidget(
            text: 'Atras',
            onPressed: ()=> Navigator.pop(context),
          )
        ],
      ),
    );
  }
}

class _ButtonResetPwd extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ButtonActionWidget(
      text: "Cambiar contraseña",
      onPressed: () => onPressed(context),
    );
  }

  void onPressed (BuildContext context) {
    sendEmailResetPwdController.resetPasswordForm.markAllAsTouched();
    if(!sendEmailResetPwdController.resetPasswordForm.valid) return;

    BlocProvider.of<UserAppBloc>(context, listen: false).add(
        RestPwdUserAppEvent(
          password: sendEmailResetPwdController.getPassword,
          token: sendEmailResetPwdController.getToken
        )
    );
  }

}

class _FormResetPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final resposive = Responsive.of(context);
    return ReactiveForm(
      formGroup: sendEmailResetPwdController.resetPasswordForm,
      child: Column(
        children: [
          _buildStackSendEmail(resposive),
          _buildToken(),
          _buildPassword(),
          _buildPasswordConfirmation(),
        ],
      ),
    );
  }

  Stack _buildStackSendEmail(Responsive responsive) {
    return Stack(
      children: [
        SizedBox(width: responsive.width),
        Positioned(
          child: Container(
            width: responsive.width-responsive.ip(6.5) - 70,
            child: _buildEmail()
          ),
        ),
        Positioned(
          top: 5,
          right: 0,
          child: _ButtonSendEmailToken(),
        )
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
      onSubmitted: () {},
      validationMessages: {
        ValidationMessage.required:'El campo es requerido',
        ValidationMessage.email: 'El email es incorrecto',
      },
    );
  }

  Widget _buildToken(){
    return RoundedInputField (
      formControlTextName: "token",
      textInputType: TextInputType.emailAddress,
      hintText: "x12axaa2",
      icon: FontAwesomeIcons.solidEnvelope,
      labelText: 'Token',
      onSubmitted: () {},
      validationMessages: {
        ValidationMessage.required: 'El campo es requerido',
        ValidationMessage.minLength: 'El token debe tener como minimo 8 caracteres',
        ValidationMessage.maxLength: 'La token debe tener como maximo 8 caracteres',
      },
    );
  }

  Widget _buildPassword(){
    return RoundedPasswordField(
      formControlTextName: 'password',
      hintText: 'As1Dw@Za2',
      labelText: 'Contraseña',
      validationMessages: {
        ValidationMessage.required:'La contraseña es requerida',
        ValidationMessage.minLength:'La contraseña debe tener como minimo 8 caracteres',
        ValidationMessage.maxLength:'La contraseña debe tener como maximo 25 caracteres',
        ValidationMessage.pattern:'Ingrese una contraseña fuerte',
      },
    );
  }

  Widget _buildPasswordConfirmation(){
    return RoundedPasswordField(
      formControlTextName: 'passwordConfirmation',
      hintText: 'As1Dw@Za2',
      labelText: 'Confirmar contraseña',
      validationMessages: {
        ValidationMessage.pattern:"Ingrese una contraseña fuerte",
        ValidationMessage.required:'La contraseña es requerida',
        ValidationMessage.mustMatch:'Las contraseñas no coinciden'
      },
    );
  }

}

class _ButtonSendEmailToken extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 58,
      width: 70,
      color: HelpersAppsColors().colorBase,
      child: IconButton(
        icon: Column(
          children: [
            FaIcon(FontAwesomeIcons.envelopeOpen),
            Text('Enviar Email', style: TextStyle(fontSize: 9, color: Colors.white))
          ]
        ),
        color: Colors.white,
        onPressed: () => _onPressed(context)
      ),
    );

  }

  void _onPressed (BuildContext context) {
    if(!sendEmailResetPwdController.isEmailValid) {
      sendEmailResetPwdController.touchErrorEmail();
      return;
    }
    BlocProvider.of<UserAppBloc>(context, listen: false).add(
        SendEmailRestPwdUserAppEvent(email: sendEmailResetPwdController.getEmail)
    );
  }

}
