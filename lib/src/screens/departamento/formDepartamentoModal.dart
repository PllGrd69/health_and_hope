import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_and_hope/src/bloc/bloc.dart';
import 'package:health_and_hope/src/form_controllers/departamentoFormController.dart';
import 'package:health_and_hope/src/utils/responsive.dart';
import 'package:health_and_hope/src/utils/textFontStyle.dart';
import 'package:health_and_hope/src/widgets/buttonCustom.dart';
import 'package:health_and_hope/src/widgets/roundedInputField.dart';
import 'package:reactive_forms/reactive_forms.dart';


class RegistrarDepartamentoWidget extends StatelessWidget {
  const RegistrarDepartamentoWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: responsive.ip(35),
          padding: EdgeInsets.all(responsive.ip(2)),
          color: Theme.of(context).scaffoldBackgroundColor,
          child: _FormRegisterDepartamento(),
        )
      ],
    );
  }

}


class _FormRegisterDepartamento extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final fontStyle = TextFontStyle.of(context);
    final responsive = Responsive.of(context);
    return ReactiveForm(
      formGroup: departamentoFormController.departamentoForm,
      child: Column(
        children: [
          Text('Registrar Departamento', style: fontStyle.subtitle2),
          SizedBox(height: responsive.ip(2)),
          _buildNombre(),
          _buttonSaveDepartamento(context),
        ],
      )
    );
  }

  Widget _buildNombre(){
    return RoundedInputField (
      formControlTextName: "nombre",
      textInputType: TextInputType.text,
      hintText: 'Nombres',
      icon: FontAwesomeIcons.solidUser,
      labelText: 'Nombres',
      onSubmitted: () {},
      validationMessages: {
        ValidationMessage.required: 'El nombre es importante',
        ValidationMessage.maxLength: 'El nombre debe tener como maximo 50 caracteres',
        ValidationMessage.minLength: 'El nombre debe tener como minimo 4 caracteres',
      },
    );
  }


  Widget _buttonSaveDepartamento(BuildContext context){
    return ButtonActionWidget(
      onPressed: () => _onPressed(context),
      text: 'Aplicar Cambios',
    );

  }

  void _onPressed(BuildContext context) async {
    FocusScope.of(context).unfocus();
    departamentoFormController.departamentoForm.markAllAsTouched();
    if (departamentoFormController.departamentoForm.invalid) return;

    BlocProvider.of<DepartamentoBloc>(context).add(
        CrearDepartamentoEvent(nombre: departamentoFormController.getNombre)
    );
    departamentoFormController.cleanData();
    SmartDialog.dismiss(tag: 'RegistrarDepartamento');
  }

}