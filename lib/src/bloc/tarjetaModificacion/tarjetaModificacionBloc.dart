import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:health_and_hope/src/models/baseModel/dataValues.dart';
import 'package:health_and_hope/src/models/models/tarjetaModificacionModel.dart';
import 'package:health_and_hope/src/repositories/tarjetaModificacionRepository.dart';

part 'tarjetaModificacionState.dart';
part 'tarjetaModificacionEvent.dart';

class TarjetaModificacionBloc extends Bloc<TarjetaModificacionEvent, TarjetaModificacionState> {
  final TarjetaModificacionRepository _tarjetaModiRepo = TarjetaModificacionRepository();

  TarjetaModificacionBloc(): super(TarjetaModificacionState().initState());

  @override
  Stream<TarjetaModificacionState> mapEventToState(TarjetaModificacionEvent event) async* {
    if (event is MisTarjetasDeModificacionEvent){
      try {
        DataValues datavalues = await _tarjetaModiRepo.misTarjetasMod();
        yield state.copyWith(
          listTarjetaModificacion: datavalues.modelValueList!=null?
          (datavalues.modelValueList as List<TarjetaModificacionModel>):null,
          listTarjetaModificacionError: datavalues.errorValue
        );
      } on Exception catch (e) {
        print(e);
        yield state.copyWith();
      }
    }
    else if (event is TarjetasDeModificacionParticipanteEvent) {
      try {
        yield state.copyWith();
        DataValues datavalues = await _tarjetaModiRepo.tarjetasModifParticipante(idParticipante: event.idParticipante);
        final objectsValue = datavalues.modelValueList!=null? (datavalues.modelValueList as List<TarjetaModificacionModel>):null;
        yield state.copyWith(
          listTarjetaModificacionParticipante: objectsValue,
          listTarjetaModificacionParticipanteError: datavalues.errorValue,
          listTarjetaModificacion: state.listTarjetaModificacion,
          listTarjetaModificacionError: state.listTarjetaModificacionError,
        );
      } on Exception catch (e) {
        print(e);
        yield state.copyWith();
      }
    }
    else if (event is RegistrarTarjetaParticipanteEvent) {
      try {
        SmartDialog.showLoading(isLoadingTemp: false,widget: Center(child: CircularProgressIndicator()));
        DataValues datavalues = await _tarjetaModiRepo.registrarTarjetaModifParticipante(tarjetaModifParticipante: event.tarjetaModifParticipante);
        final objectsValue = datavalues.modelValue!=null? (datavalues.modelValue as TarjetaModificacionModel):null;
        if (objectsValue!=null) state.listTarjetaModificacionParticipante!.add(objectsValue);
        SmartDialog.dismiss();
        yield state.copyWith(
          listTarjetaModificacionParticipante: state.listTarjetaModificacionParticipante,
          listTarjetaModificacionParticipanteError: datavalues.errorValue,
          listTarjetaModificacion: state.listTarjetaModificacion,
          listTarjetaModificacionError: state.listTarjetaModificacionError,
        );
      } on Exception catch (e) {
        print(e);
        SmartDialog.dismiss();
        yield state.copyWith();
      } finally {
        await Future.delayed(Duration(seconds: 1));
        SmartDialog.dismiss();
      }
    }
    else if (event is EliminarTarjetaParticipanteEvent) {
      try {
        SmartDialog.showLoading(isLoadingTemp: false,widget: Center(child: CircularProgressIndicator()));
        DataValues datavalues = await _tarjetaModiRepo.eliminarTarjetaModifParticipante(idTarjetaModif: event.idTarjetaModif);
        state.listTarjetaModificacionParticipante  = state.listTarjetaModificacionParticipante!.where((item) => item.id != event.idTarjetaModif).toList();
        SmartDialog.dismiss();
        yield state.copyWith(
          listTarjetaModificacionParticipante: state.listTarjetaModificacionParticipante,
          listTarjetaModificacionParticipanteError: datavalues.errorValue,
          listTarjetaModificacion: state.listTarjetaModificacion,
          listTarjetaModificacionError: state.listTarjetaModificacionError,
        );
      } on Exception catch (e) {
        print(e);
        SmartDialog.dismiss();
        yield state.copyWith();
      } finally {
        await Future.delayed(Duration(seconds: 1));
        SmartDialog.dismiss();
      }
    }

    else if (event is ActualizarTarjetaParticipanteEvent) {
      try {
        SmartDialog.showLoading(isLoadingTemp: false,widget: Center(child: CircularProgressIndicator()));
        DataValues datavalues = await _tarjetaModiRepo.actualizarTarjetaModifParticipante(tarjetaModifParticipante: event.tarjetaModifParticipante);
        final objectsValue = datavalues.modelValue!=null? (datavalues.modelValue as TarjetaModificacionModel):null;
        if (objectsValue!=null) {
          print(objectsValue);
          state.listTarjetaModificacionParticipante = state.listTarjetaModificacionParticipante!.map((e) => (e.id==objectsValue.id)?objectsValue:e).toList();
        }
        SmartDialog.dismiss();
        yield state.copyWith(
          listTarjetaModificacionParticipante: state.listTarjetaModificacionParticipante,
          listTarjetaModificacionParticipanteError: datavalues.errorValue,
          listTarjetaModificacion: state.listTarjetaModificacion,
          listTarjetaModificacionError: state.listTarjetaModificacionError,
        );
      } on Exception catch (e) {
        print(e);
        SmartDialog.dismiss();
        yield state.copyWith();
      } finally {
        await Future.delayed(Duration(seconds: 1));
        SmartDialog.dismiss();
      }

    }
  }

}