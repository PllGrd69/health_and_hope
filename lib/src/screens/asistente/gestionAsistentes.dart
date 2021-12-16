import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_and_hope/src/bloc/asistente/asistenteBloc.dart';
import 'package:health_and_hope/src/form_controllers/asistentesBuscarFormController.dart';
import 'package:health_and_hope/src/screens/asistente/listaAsistentesWidget.dart';
import 'package:health_and_hope/src/screens/registrarUsuarioScreen.dart';
import 'package:health_and_hope/src/utils/responsive.dart';
import 'package:health_and_hope/src/utils/textFontStyle.dart';
import 'package:health_and_hope/src/utils/userRole.dart';
import 'package:health_and_hope/src/widgets/buttonCustom.dart';
import 'package:health_and_hope/src/widgets/roundedInputField.dart';
import 'package:reactive_forms/reactive_forms.dart';


class GestionAsistentes extends StatelessWidget {
  const GestionAsistentes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    final textFontStyle = TextFontStyle.of(context);

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(responsive.ip(3)),
          height: responsive.height,
          width: responsive.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Lista de asistentes', style: textFontStyle.title2, textAlign: TextAlign.center),
              SizedBox(height: responsive.ip(4)),
              _busquedaPersonalizadaBtn(context),
              Expanded(child: ListaAsistentes()),
              SizedBox(height: responsive.ip(2)),
            ]
          )
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "RegisterUserAsistenteScreen",
        onPressed: () {
          Navigator.pushNamed(context, RegistrarUsuarioScreen.routeName, arguments: RoleUser.asistente);
        },
        child: FaIcon(FontAwesomeIcons.plus),
      ),
    );
  }

  Widget _busquedaPersonalizadaBtn(BuildContext context){
    final responsive = Responsive.of(context);
    return Container(
      width: responsive.width,
      child: ButtonActionWidget(
          text: 'Busqueda Personalizada',
          // padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          onPressed: ()=> _busquedaPersonalizada(context)
      ),
    );
  }

  void _busquedaPersonalizada(BuildContext context) {
    final responsive = Responsive.of(context);
    showModalBottomSheet(
      context: context,
      builder: (context)=> Container(
          padding: EdgeInsets.all(responsive.ip(2)),
          child: _BuscarAsistenteForm()
      ),
    );
  }

}

class _BuscarAsistenteForm extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    return Container(
      width: responsive.width,
      child: ReactiveForm(
        formGroup: buscarAsistentesTodosFormController.buscarAsistenteTodosForm,
        child: Column(
          children: [
            _buildDNI(),
            _buildEmail(),
            _buscar(context),
          ],
        )
      ),
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
        ValidationMessage.maxLength: 'El DNI debe tener 8 caracteres',
        ValidationMessage.number:"El DNI debe ser numérico",
      },
    );
  }

  Widget _buildEmail(){
    return RoundedInputField (
      formControlTextName: "email",
      textInputType: TextInputType.number,
      icon: FontAwesomeIcons.idCard,
      hintText: "Email",
      labelText: 'Email',
      onSubmitted: () {},
      validationMessages: {
        ValidationMessage.maxLength: "Esta campo debe tener como maximo 100 caracteres",
      },
    );
  }

  Widget _buscar(BuildContext context){
    return ButtonActionWidget(
        text: 'Buscar',
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        onPressed: ()=> _onPressed(context)
    );
  }

  void _onPressed(BuildContext context) {
    buscarAsistentesTodosFormController.buscarAsistenteTodosForm.markAllAsTouched();
    FocusScope.of(context).unfocus();
    if (!buscarAsistentesTodosFormController.buscarAsistenteTodosForm.valid) return;

    BlocProvider.of<AsistenteBloc>(context).add(AsistentesEvent(
        email:  buscarAsistentesTodosFormController.getEmail,
        dni: buscarAsistentesTodosFormController.getDni
    ));


  }
}

