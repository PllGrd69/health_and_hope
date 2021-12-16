import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:health_and_hope/src/models/baseModel/dataValues.dart';
import 'package:health_and_hope/src/models/baseModel/models.dart';
import 'package:health_and_hope/src/repositories/progresoActividadRepository.dart';

part 'progresoActividadEvent.dart';
part 'progresoActividadState.dart';



class ProgresoActividadBloc extends Bloc<ProgresoActividadEvent, ProgroseActividadState> {
  final ProgresoActividadRepository _progresActivi = ProgresoActividadRepository();

  ProgresoActividadBloc(): super(ProgroseActividadState().initState());

  @override
  Stream<ProgroseActividadState> mapEventToState(ProgresoActividadEvent event) async* {
    if (event is MiProgresoActividadEvent){
      try {
        DataValues datavalues = await _progresActivi.miProgresoActividad();
        yield state.copyWith(
          listProgresoActividad: datavalues.modelValueList!=null?
          (datavalues.modelValueList as List<ProgresoActividadDiarioModel>):null,
          listProgresoActividadError: datavalues.errorValue,
          listTarjetaProgresoActividad: state.listTarjetaProgresoActividad,
          listTarjetaProgresoActividadError: state.listTarjetaProgresoActividadError,
        );
      } on Exception catch (e) {
        print(e);
        yield state.copyWith();
      }
    }
    else if (event is MiTarjetaProgresoActividadEvent) {
      try {
        DataValues datavalues = await _progresActivi.misTarjetasProgresoActividad();
        yield state.copyWith(
          listTarjetaProgresoActividad: datavalues.modelValueList!=null?
          (datavalues.modelValueList as List<ProgresoActividadDiarioModel>):null,
          listTarjetaProgresoActividadError: datavalues.errorValue,
          listProgresoActividad: state.listProgresoActividad,
          listProgresoActividadError: state.listProgresoActividadError
        );
      } on Exception catch (e) {
        print(e);
        yield state.copyWith();
      }
    }

  }

}