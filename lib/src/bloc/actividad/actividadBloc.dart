import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:health_and_hope/src/models/baseModel/dataValues.dart';
import 'package:health_and_hope/src/models/models/actividadModel.dart';
import 'package:health_and_hope/src/models/models/actividadUsuario.dart';
import 'package:health_and_hope/src/repositories/actividadesRepository.dart';


part 'actividadEvent.dart';
part 'actividadState.dart';


class ActividadBloc extends Bloc<ActividadEvent, ActividadState> {
  final ActividadRepository _tarjetaModiRepo = ActividadRepository();

  ActividadBloc(): super(ActividadState().initState());

  @override
  Stream<ActividadState> mapEventToState(ActividadEvent event) async* {
    if (event is MisActividadesEvent){
      try {
        yield state.copyWith();
        DataValues datavalues = await _tarjetaModiRepo.misActividadesModif(event.uidTarjetaModif);

        yield state.copyWith(
            listActividadesHoy: datavalues.modelValueList!=null?
            (datavalues.modelValueList as List<ActividadUsuarioModel>):null,
            listActividadesHoyError: datavalues.errorValue
        );
      } on Exception catch (e) {
        print(e);
        yield state.copyWith();
      }
    }
    else if (event is CambiarMiEstadoActividadEvent){
      try {
        SmartDialog.showLoading();
        DataValues datavalues = await _tarjetaModiRepo.cambiarMiEstadoActividad(
          uuidEstado: event.uuidEstado,
          uuidActividad: event.uuidActividad
        );
        final nuevoEstadoActv = (datavalues.modelValue!=null)?datavalues.modelValue as ActividadModel:null;
        final newState = state.listActividadesHoy!.map((e){
          if (nuevoEstadoActv!=null && e.id == event.uuidActividad) e.estadoActividad = nuevoEstadoActv.estadoActividad;
          return e;
        }).toList();
        yield state.copyWith(
          listActividadesHoy: newState,
            listActividadesHoyError: datavalues.errorValue
        );
      } on Exception catch (e) {
        print(e);
        yield state.copyWith();
      } finally {
        SmartDialog.dismiss();
      }
    }
  }

}