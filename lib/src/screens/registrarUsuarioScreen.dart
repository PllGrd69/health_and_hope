import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_and_hope/src/form_controllers/register_screen_controller.dart';
import 'package:health_and_hope/src/bloc/bloc.dart';
import 'package:health_and_hope/src/models/baseModel/models.dart';
import 'package:health_and_hope/src/utils/responsive.dart';
import 'package:health_and_hope/src/utils/userRole.dart';
import 'package:health_and_hope/src/widgets/buttonCustom.dart';
import 'package:health_and_hope/src/widgets/datePickerFieldCustomWidget.dart';
import 'package:health_and_hope/src/widgets/dropdownFieldCustomWidget.dart';
import 'package:health_and_hope/src/widgets/widgets.dart';
import 'package:intl/intl.dart';
import 'package:reactive_forms/reactive_forms.dart';

class RegistrarUsuarioScreen extends StatelessWidget {

  final String tipoUsuario;
  static final routeName = 'RegistrarUsuarioScreen';
  RegistrarUsuarioScreen({Key? key, required this.tipoUsuario}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    registerUserController.setRol = tipoUsuario;
    final responsive = Responsive.of(context);
    usuarioCreadoMensaje(context);

    final containerForm = Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          ReactiveForm(
            formGroup: registerUserController.registerForm,
            child: Column (
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: responsive.ip(2.5)),
                Text('Proceda con el registro ${
                    (tipoUsuario==RoleUser.personal)?
                    'personal':
                    (tipoUsuario==RoleUser.admin_app)?
                    'administrador de la app':
                    (tipoUsuario==RoleUser.participante)?
                    'participante':
                    (tipoUsuario==RoleUser.asistente)?
                    'asistente': 'rol no encontrado'
                }'),
                SizedBox(height: responsive.ip(2)),
                _buildFirstName(),
                SizedBox(height: responsive.ip(1)),
                _buildLastName(),
                SizedBox(height: responsive.ip(1)),
                _buildUserName(),
                SizedBox(height: responsive.ip(1)),
                _buildEmail(),
                SizedBox(height: responsive.ip(1)),
                _buildPassword(),
                SizedBox(height: responsive.ip(1)),
                _buildPasswordConfirmation(),
                SizedBox(height: responsive.ip(1)),
                _buildDNI(),
                SizedBox(height: responsive.ip(1)),
                _buildDireccionActual(),
                SizedBox(height: responsive.ip(1)),
                _buildDropDownGenero(),
                SizedBox(height: responsive.ip(1)),
                _buildFechaNacimiento(context),
                SizedBox(height: responsive.ip(4.1)),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _ButtonSubmit(),
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

  void usuarioCreadoMensaje(BuildContext context) {
    final state = BlocProvider.of<UserBloc>(context, listen: true).state;
    if (state.userCreated != null){
      state.userCreated = null;
      print("Usuario creado correctamene");
      registerUserController.cleanData();
    }
  }

  Widget _buildDropDownGenero(){
    return DropdownFieldCustomWidget(
      onChanged: ()=>{},
      formControlTextName: 'genero',
      validationMessages: {
        ValidationMessage.required:'El genero es requerido son requerido',
      },
      labelText: 'Género',
      icon: FontAwesomeIcons.restroom,
      items: [
        DropdownMenuItem(
          value: '2',
          child: Text('Otro'),
        ),
        DropdownMenuItem(
          value: '0',
          child: Text('Masculino'),
        ),
        DropdownMenuItem(
          value: '1',
          child: Text('Femenino'),
        ),
      ],
    );
  }

  Widget _buildDNI(){
    return RoundedInputField (
      formControlTextName: "dni",
      textInputType: TextInputType.number,
      icon: FontAwesomeIcons.idCard,
      hintText: "DNI",
      labelText: 'DNI',
      onSubmitted: () {},
      validationMessages: {
        ValidationMessage.required:'El DNI es requerido',
        ValidationMessage.maxLength: 'El DNI debe tener 8 caracteres',
        ValidationMessage.minLength: 'El DNI debe tener 8 caracteres',
        ValidationMessage.number:"El DNI debe ser numérico",
      },
    );
  }

  Widget _buildDireccionActual(){
    return RoundedInputField (
      formControlTextName: "direccionActual",
      textInputType: TextInputType.text,
      icon: FontAwesomeIcons.solidUser,
      hintText: "Dirección actual",
      labelText: 'Dirección actual',
      onSubmitted: () {},
      validationMessages: {
        ValidationMessage.required:'La dirección es requerida',
        ValidationMessage.maxLength: 'La dirección deben tener como maximo 75 caracteres',
      },
    );
  }

  Widget _buildFechaNacimiento(BuildContext context){
    return DatePickerFieldCustomWidget(
      formControlTextName: 'fechaNacimiento',
      validationMessages: {
        ValidationMessage.required: 'La fecha de nacimiento es requerida',
      },
      labelText: 'Fecha de nacimiento',
      firstDate: DateTime(1985),
      lastDate: DateTime(2030),
      icon: FontAwesomeIcons.birthdayCake,
    );
  }


  Widget _buildFirstName(){
    return RoundedInputField (
      formControlTextName: "nombres",
      textInputType: TextInputType.text,
      icon: FontAwesomeIcons.solidUser,
      hintText: "Nombres",
      labelText: 'Nombres',
      onSubmitted: () {
        registerUserController.registerForm.focus('apellidos');
      },
      // icon: Icons.person_pin,
      validationMessages: {
        ValidationMessage.required:'Los nombres son requerido',
        ValidationMessage.maxLength: 'Los nombres deben tener como maximo 50 caracteres',
      },
    );
  }

  Widget _buildLastName(){
    return RoundedInputField (
      formControlTextName: "apellidos",
      textInputType: TextInputType.text,
      icon: FontAwesomeIcons.solidUser,
      hintText: "Apellidos",
      labelText: 'Apellidos',
      onSubmitted: () {
        registerUserController.registerForm.focus('user');
      },
      // icon: Icons.person_pin,
      validationMessages: {
        ValidationMessage.required:'Los apellidos son requeridos',
        ValidationMessage.maxLength: 'Los apellidos deben tener como maximo 50 caracteres',
      },
    );
  }

  Widget _buildUserName(){
    return RoundedInputField (
      formControlTextName: "user",
      textInputType: TextInputType.text,
      hintText: "Lucas",
      icon: FontAwesomeIcons.solidUser,
      labelText: 'Nombre de usuario',
      onSubmitted: () {
        registerUserController.registerForm.focus('email');
      },
      // icon: Icons.person_pin,
      validationMessages: {
        ValidationMessage.required:'El nombre de usuario es requerido',
        ValidationMessage.minLength: 'El nombre de usuario debe tener como minimo 5 caracteres',
        ValidationMessage.maxLength: 'El nombre de usuario debe tener como maximo 20 caracteres',
      },
    );

  }

  Widget _buildEmail(){
    return RoundedInputField (
      formControlTextName: "email",
      textInputType: TextInputType.emailAddress,
      icon: FontAwesomeIcons.solidEnvelope,
      hintText: "example@xd.com",
      labelText: 'Email',
      onSubmitted: () {
        registerUserController.registerForm.focus('password');
      },
      // icon: Icons.alternate_email_sharp,
      validationMessages: {
        ValidationMessage.required:'El email es requerido',
        ValidationMessage.email: 'El email es incorrecto',
        ValidationMessage.minLength: 'El email debe tener como minimo 5 caracteres',
        ValidationMessage.maxLength: 'El email debe tener como maximo 60 caracteres',
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


class _ButtonSubmit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ButtonActionWidget(
      onPressed: () => _onPressed(context),
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      text: 'Registrar',
    );
  }

  void _onPressed(BuildContext context) {
    FocusScope.of(context).unfocus();
    registerUserController.registerForm.markAllAsTouched();
    if (registerUserController.registerForm.invalid) return;


    String fechaNacimiento = DateFormat('yyyy-MM-dd').format(registerUserController.getFechaNacimiento);
    final userAppBloc = BlocProvider.of<UserBloc>(context, listen: false);
    if (registerUserController.registerForm.valid) {
      userAppBloc.add(
        UserRegisterEvent(userCreated: CreateUserModel(
          email: registerUserController.getEmail,
          firstName: registerUserController.getNombres,
          lastName: registerUserController.getApellidos,
          username: registerUserController.getUser,
          password: registerUserController.getPassword,
          direccionActual: registerUserController.getDireccionActual,
          dni: registerUserController.getDni,
          fechaNacimiento: fechaNacimiento,
          genero: registerUserController.getGenero,
          rol: registerUserController.getRol
        ))
      );
    }
  }
}