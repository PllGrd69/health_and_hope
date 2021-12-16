import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_and_hope/src/bloc/bloc.dart';
import 'package:health_and_hope/src/form_controllers/registroTarjetaModifFormController.dart';
import 'package:health_and_hope/src/models/baseModel/models.dart';
import 'package:health_and_hope/src/models/models/tarjetaModificacionModel.dart';
import 'package:health_and_hope/src/utils/responsive.dart';
import 'package:health_and_hope/src/utils/textFontStyle.dart';
import 'package:health_and_hope/src/widgets/buttonCustom.dart';
import 'package:health_and_hope/src/widgets/datePickerFieldCustomWidget.dart';
import 'package:health_and_hope/src/widgets/roundedInputField.dart';
import 'package:health_and_hope/src/widgets/timePickerFieldCustomWidget.dart';
import 'package:intl/intl.dart';
import 'package:reactive_forms/reactive_forms.dart';

class TarjetaModificacionRegistroScreen extends StatelessWidget {
  final ParticipanteModel participante;
  static final String routeName = 'TarjetaModificacionRegistroScreen';

  const TarjetaModificacionRegistroScreen({required this.participante});
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    final textFontStyle = TextFontStyle.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: responsive.width, height: responsive.ip(2)),
              Text('Registro de tarjeta de modificación - ${participante.participante!.email}', style: textFontStyle.subtitle1, textAlign: TextAlign.center),
              _FormRegisterTarjetaModif(participante: participante)
            ],
          ),
        ),
      ),
    );
  }
  
}


class _FormRegisterTarjetaModif extends StatelessWidget {
  final ParticipanteModel participante;

  const _FormRegisterTarjetaModif({Key? key,required this.participante}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    return Container(
      padding: EdgeInsets.all(responsive.ip(2)),
      child: ReactiveForm(
        formGroup: registroTarjetaModifFormController.registroTarjetaModifForm,
        child: Column(
          children: [
            _buildTituloTarjeta(),
            _buildFechaInicioActividad(),
            _buildFechaFinalizacionActividad(),
            _buildHoraEntregaActividad(),
            _buildHoraFinalizacionEntregaActividad(),
            _ButtonSubmit(participante: participante),
          ],
        ),
      ),
    );
  }

  Widget _buildHoraEntregaActividad(){
    return TimePickerFieldCustomWidget(
      formControlTextName: 'horaActividadEntrega',
      validationMessages: {
        ValidationMessage.required: 'La fecha de nacimiento es requerida',
      },
      labelText: 'Hora de entrega',
      icon: FontAwesomeIcons.userClock,
    );
  }

  Widget _buildHoraFinalizacionEntregaActividad(){
    return TimePickerFieldCustomWidget(
      formControlTextName: 'horaActividadEntregaFin',
      validationMessages: {
        ValidationMessage.required: 'La fecha de nacimiento es requerida',
      },
      labelText: 'Hora de finalizacion',
      icon: FontAwesomeIcons.userClock,
    );
  }

  Widget _buildFechaInicioActividad(){
    return DatePickerFieldCustomWidget(
      firstDate: DateTime(1985),
      lastDate: DateTime(2030),
      formControlTextName: 'fechaInicio',
      validationMessages: {
        ValidationMessage.required: 'La fecha de nacimiento es requerida',
      },
      labelText: 'Fecha de inicio',
      icon: FontAwesomeIcons.solidCalendarAlt,
    );
  }

  Widget _buildFechaFinalizacionActividad(){
    return DatePickerFieldCustomWidget(
      firstDate: DateTime(1985),
      lastDate: DateTime(2030),
      formControlTextName: 'fechaFin',
      validationMessages: {
        ValidationMessage.required: 'La fecha de nacimiento es requerida',
      },
      labelText: 'Fecha de finalización',
      icon: FontAwesomeIcons.solidCalendarAlt,
    );
  }

  Widget _buildTituloTarjeta(){
    return RoundedInputField (
      formControlTextName: "titulo",
      textInputType: TextInputType.text,
      icon: FontAwesomeIcons.solidAddressBook,
      hintText: "Titulo de la tarjeta",
      labelText: 'Titulo de la tarjeta',
      onSubmitted: () {},
      validationMessages: {
        ValidationMessage.required:'El titulo es requerida',
        ValidationMessage.maxLength: 'El titulo debe tener como maximo 65 caracteres',
      },
    );
  }
}


class _ButtonSubmit extends StatelessWidget {
  final ParticipanteModel participante;

  const _ButtonSubmit({Key? key,required this.participante}) : super(key: key);
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
    registroTarjetaModifFormController.registroTarjetaModifForm.markAllAsTouched();
    if (registroTarjetaModifFormController.registroTarjetaModifForm.invalid) return;

    final horaActividadEntrega = registroTarjetaModifFormController.getHoraActividadEntrega;
    final horaActividadEntregaFin = registroTarjetaModifFormController.getHoraActividadEntregaFin;

    final dateFormat = DateFormat('yyyy-MM-dd');
    TarjetaModificacionModel tarjetaModif = TarjetaModificacionModel(
      titulo: registroTarjetaModifFormController.getTitulo,
      fechaInicio: dateFormat.format(registroTarjetaModifFormController.getFechaInicio),
      fechaFin:  dateFormat.format(registroTarjetaModifFormController.getFechaFin),
      horaActividadEntrega: '${horaActividadEntrega.hour}:${horaActividadEntrega.minute}:00',
      horaActividadEntregaFin: '${horaActividadEntregaFin.hour}:${horaActividadEntregaFin.minute}:00',
      participante: participante.id!
    );

    BlocProvider.of<TarjetaModificacionBloc>(context).add(
        RegistrarTarjetaParticipanteEvent(tarjetaModifParticipante: tarjetaModif)
    );

  }

}
