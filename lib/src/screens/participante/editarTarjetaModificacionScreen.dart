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

class TarjetaModificacionEditarScreen extends StatelessWidget {
  final TarjetaModificacionModel tarjetaModificacion;
  static final String routeName = 'TarjetaModificacionEditarScreen';

  const TarjetaModificacionEditarScreen({required this.tarjetaModificacion});
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    final textFontStyle = TextFontStyle.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column (
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: responsive.width, height: responsive.ip(2)),
              BlocBuilder<TarjetaModificacionBloc, TarjetaModificacionState>(
                  builder: (context, state) {
                    if(state.listTarjetaModificacionParticipante!=null) {
                      final item = state.listTarjetaModificacionParticipante!.where((e) => e.id == tarjetaModificacion.id).toList().first;
                      return Text('Editar de tarjeta de modificación - ${item.titulo}', style: textFontStyle.subtitle1, textAlign: TextAlign.center);
                    }
                    return Text('Editar de tarjeta de modificación - ${tarjetaModificacion.titulo}', style: textFontStyle.subtitle1, textAlign: TextAlign.center);
                  }
              ),
              _FormEditarTarjetaModif(tarjetaModificacion: tarjetaModificacion)
            ],
          ),
        ),
      ),
    );
  }
  
}


class _FormEditarTarjetaModif extends StatelessWidget {
  final TarjetaModificacionModel tarjetaModificacion;

  const _FormEditarTarjetaModif({Key? key,required this.tarjetaModificacion}) : super(key: key);
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
            _ButtonSubmit(tarjetaModificacion: tarjetaModificacion),
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
        ValidationMessage.required:'El titulo es requerido',
        ValidationMessage.maxLength: 'El titulo debe tener como maximo 65 caracteres',
      },
    );
  }
}


class _ButtonSubmit extends StatelessWidget {
  final TarjetaModificacionModel tarjetaModificacion;

  const _ButtonSubmit({Key? key,required this.tarjetaModificacion}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ButtonActionWidget(
      onPressed: () => _onPressed(context),
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      text: 'Guardar cambios',
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
      id: tarjetaModificacion.id,
      titulo: registroTarjetaModifFormController.getTitulo,
      fechaInicio: dateFormat.format(registroTarjetaModifFormController.getFechaInicio),
      fechaFin:  dateFormat.format(registroTarjetaModifFormController.getFechaFin),
      horaActividadEntrega: '${horaActividadEntrega.hour}:${horaActividadEntrega.minute}:00',
      horaActividadEntregaFin: '${horaActividadEntregaFin.hour}:${horaActividadEntregaFin.minute}:00',
      participante: tarjetaModificacion.participante!
    );

    BlocProvider.of<TarjetaModificacionBloc>(context).add(
        ActualizarTarjetaParticipanteEvent(
          tarjetaModifParticipante: tarjetaModif,
        )
    );

  }

}
