import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';


class _RegistroTarjetaModifFormController {

  final FormGroup registroTarjetaModifForm = FormGroup({
    'titulo':FormControl<String>(
      validators: [
        Validators.required,
        Validators.maxLength(65),
      ],
      value: ''
    ),
    'fechaInicio': FormControl<DateTime>(
      validators: [
        Validators.required,
      ],
      value: null
    ),
    'fechaFin': FormControl<DateTime>(
        validators: [
          Validators.required,
        ],
        value: null
    ),
    'horaActividadEntrega': FormControl<TimeOfDay>(
        validators: [
          Validators.required,
        ],
        value: null
    ),
    'horaActividadEntregaFin': FormControl<TimeOfDay>(
        validators: [
          Validators.required,
        ],
        value: null
    ),
  });

  void cleanData() {
    registroTarjetaModifForm.control('titulo').reset();
    registroTarjetaModifForm.control('fechaInicio').reset();
    registroTarjetaModifForm.control('fechaFin').reset();
    registroTarjetaModifForm.control('horaActividadEntrega').reset();
    registroTarjetaModifForm.control('horaActividadEntregaFin').reset();
  }

  set setTitulo(String titulo) => this.registroTarjetaModifForm.control('titulo').value = titulo;
  String get getTitulo => this.registroTarjetaModifForm.control('titulo').value;
  set errorTitulo(String value) => this.registroTarjetaModifForm.control('titulo').setErrors({value:'titulo'});

  set setFechaInicio(DateTime fecha) => this.registroTarjetaModifForm.control('fechaInicio').value = fecha;
  DateTime get getFechaInicio => this.registroTarjetaModifForm.control('fechaInicio').value;
  set errorFechaInicio(String value) => this.registroTarjetaModifForm.control('fechaInicio').setErrors({value:'fechaInicio'});

  set setFechaFin(DateTime fecha) => this.registroTarjetaModifForm.control('fechaFin').value = fecha;
  DateTime get getFechaFin => this.registroTarjetaModifForm.control('fechaFin').value;
  set errorFechaFin(String value) => this.registroTarjetaModifForm.control('fechaFin').setErrors({value:'fechaFin'});

  set setHoraActividadEntrega(TimeOfDay hora) => this.registroTarjetaModifForm.control('horaActividadEntrega').value = hora;
  TimeOfDay get getHoraActividadEntrega => this.registroTarjetaModifForm.control('horaActividadEntrega').value;
  set errorHoraActividadEntrega(String value) => this.registroTarjetaModifForm.control('horaActividadEntrega').setErrors({value:'horaActividadEntrega'});

  set setHoraActividadEntregaFin(TimeOfDay hora) => this.registroTarjetaModifForm.control('horaActividadEntregaFin').value = hora;
  TimeOfDay get getHoraActividadEntregaFin => this.registroTarjetaModifForm.control('horaActividadEntregaFin').value;
  set errorHoraActividadEntregaFin(String value) => this.registroTarjetaModifForm.control('horaActividadEntregaFin').setErrors({value:'horaActividadEntregaFin'});

  void errorFormsMapFromApi(Map<dynamic,dynamic>? errors){
    if (errors!=null) {
      if (errors.containsKey('titulo')) errorTitulo = errors['titulo'][0];
      if (errors.containsKey('fechaInicio')) errorFechaInicio = errors['fechaInicio'][0];
      if (errors.containsKey('fechaFin')) errorFechaFin = errors['fechaFin'][0];
      if (errors.containsKey('horaActividadEntrega')) errorHoraActividadEntrega = errors['horaActividadEntrega'][0];
      if (errors.containsKey('horaActividadEntregaFin')) errorHoraActividadEntregaFin = errors['horaActividadEntregaFin'][0];
    }
  }

}



final registroTarjetaModifFormController = _RegistroTarjetaModifFormController();