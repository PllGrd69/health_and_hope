import 'dart:convert';
import 'dart:io' as Io;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:health_and_hope/src/models/baseModel/models.dart';
import 'package:health_and_hope/src/repositories/personalRepository.dart';



part 'personalEvent.dart';
part 'personalState.dart';

class PersonalBloc extends Bloc<PersonalEvent, PersonalState> {
  final PersonalRepository _personalRepository = PersonalRepository();
  PersonalBloc(): super(PersonalState().initState());

  @override
  Stream<PersonalState> mapEventToState(PersonalEvent event)  async* {
    if (event is AllPersonalEvent){
      try {
        DataValues datavalues = await _personalRepository.allPersonal();
        final listValue = datavalues.modelValueList!=null?(datavalues.modelValueList as List<PersonalModel>):null;
        yield state.copyWith(
            listPersonal: listValue,
            listPersonalError: datavalues.errorValue
        );
      } on Exception catch (_) {
        yield state.copyWith();
      }
    }
    else if (event is ListaPersonalEvent) {
      try {
        yield state.copyWith();
        DataValues datavalues = await _personalRepository.listaPersonal(dni: event.dni, email: event.email, page: 1);
        final object = (datavalues.modelValue!=null)?(datavalues.modelValue as PersonalModelPagModel) : null;
        yield state.copyWith(
          listPersonalPag: object,
          listPersonalPagError: datavalues.errorValue
        );
      } on Exception catch (_) {
        yield state.copyWith();
      }
    }
    else if (event is ListaPersonalPagEvent) {
      try {
        SmartDialog.showLoading(isLoadingTemp: false, widget: Center(child: CircularProgressIndicator()));
        DataValues datavalues = await _personalRepository.listaPersonal(dni: event.dni, email: event.email, page: event.page);
        if (datavalues.statusCode != 404) {
          final object = (datavalues.modelValue!=null)?(datavalues.modelValue as PersonalModelPagModel) : null;
          state.listPersonalPag!.results = [...state.listPersonalPag!.results!,...object!.results!];
        }
        SmartDialog.dismiss();
        yield state.copyWith(
            listPersonalPag: state.listPersonalPag,
            listPersonalPagError: datavalues.errorValue
        );
      } on Exception catch (_) {
        SmartDialog.dismiss();
        yield state.copyWith();
      } finally {
        await Future.delayed(Duration(seconds: 1));
        SmartDialog.dismiss();
      }
    }
    else if (event is EliminarPersonalPagEvent) {
      try {
        SmartDialog.showLoading(isLoadingTemp: false, widget: Center(child: CircularProgressIndicator()));
        DataValues datavalues = await _personalRepository.eliminarPersonal(idPersonal: event.idPersonal);
        if (datavalues.errorValue == null) {
          state.listPersonalPag!.results = state.listPersonalPag!.results!.where((item) => item.id!=event.idPersonal).toList();
        }
        SmartDialog.dismiss();
        yield state.copyWith(
            listPersonalPag: state.listPersonalPag,
            listPersonalPagError: datavalues.errorValue
        );
      } on Exception catch (_) {
        SmartDialog.dismiss();
        yield state.copyWith();
      } finally {
        await Future.delayed(Duration(seconds: 1));
        SmartDialog.dismiss();
      }
    }
  }
}