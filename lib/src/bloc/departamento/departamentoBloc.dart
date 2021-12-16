import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:health_and_hope/src/models/baseModel/models.dart';
import 'package:health_and_hope/src/repositories/departamentoRepository.dart';

part 'departamentoEvent.dart';
part 'departamentoState.dart';


class DepartamentoBloc extends Bloc<DepartamentoEvent, DepartamentoState> {
  final DepartamentoRepository _departamentoRepo = DepartamentoRepository();

  DepartamentoBloc() : super(DepartamentoState().initState());

  @override
  Stream<DepartamentoState> mapEventToState(DepartamentoEvent event) async* {
    if (event is AllDepartamentos) {
      try {
        DataValues datavalues = await _departamentoRepo.allDepartamentos();
        yield state.copyWith(
            listDepartamento: datavalues.modelValueList != null ?
            (datavalues.modelValueList as List<DepartamentoModel>) : null,
            listDepartamentoError: datavalues.errorValue
        );
      } on Exception catch (e) {
        print(e);
        yield state.copyWith();
      }
    }
    else if (event is CrearDepartamentoEvent) {
      try {
        SmartDialog.showLoading();
        DataValues datavalues = await _departamentoRepo.crearDepartamento(nombre: event.nombre);
        final valueInsert = (datavalues.modelValue!=null) ? (datavalues.modelValue as DepartamentoModel): null;
        if (valueInsert!=null)state.listDepartamento!.add(valueInsert);
        yield state.copyWith(
            listDepartamento: state.listDepartamento,
            listDepartamentoError: datavalues.errorValue
        );
      } on Exception catch (e) {
        yield state.copyWith();
      } finally{
        SmartDialog.dismiss();
      }
    }
  }

}