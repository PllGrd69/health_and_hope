import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:health_and_hope/src/models/baseModel/models.dart';
import 'package:health_and_hope/src/repositories/asistenteRepository.dart';

part 'asistenteEvent.dart';
part 'asistenteState.dart';

class AsistenteBloc extends Bloc<AsistenteEvent, AsistenteState> {
  final AsistenteRepository _asistenteRepo = AsistenteRepository();
  AsistenteBloc() : super(AsistenteState().initState());
  @override
  Stream<AsistenteState> mapEventToState(AsistenteEvent event) async* {
    final listAsistenteParticipante = state.listAsistenteParticipante;
    final listAsistenteParticipanteError = state.listAsistenteParticipanteError;
    final asistenteDisponiPagParticipante = state.asistenteDisponiPagParticipante;
    final asistenteDisponiPagParticipanteError = state.asistenteDisponiPagParticipanteError;
    final asistentesPag = state.asistentesPag;
    final asistentesPagError = state.asistentesPagError;

    if (event is AsistentesParticipanteEvent) {
      try {
        yield state.copyWith();
        DataValues datavalues = await _asistenteRepo.asistentesParticipante(idParticipante: event.idParticipante);
        final valuesObject = (datavalues.modelValueList!=null)? (datavalues.modelValueList as List<AsistenteModel>):null;
        yield state.copyWith(
          listAsistenteParticipante: valuesObject,
          listAsistenteParticipanteError: datavalues.errorValue,
          asistenteDisponiPagParticipante: asistenteDisponiPagParticipante,
          asistenteDisponiPagParticipanteError: asistenteDisponiPagParticipanteError,
          asistentesPag: asistentesPag,
          asistentesPagError:asistentesPagError
        );
      } on Exception catch (e) {
        print(e);
        yield state.copyWith();
      }
    }
    else if (event is AsistentesDisponiParticipanteEvent) {
      try {
        yield state.copyWith();
        DataValues datavalues = await _asistenteRepo.asistentesDisponiblesParticipante(idParticipante: event.idParticipante, email: event.email, dni: event.dni, page: 1);
        final valuesObject = (datavalues.modelValue!=null)? (datavalues.modelValue as AsistentePaginadoModel):null;
        yield state.copyWith(
          listAsistenteParticipante: listAsistenteParticipante,
          listAsistenteParticipanteError: listAsistenteParticipanteError,
          asistenteDisponiPagParticipante: valuesObject,
          asistenteDisponiPagParticipanteError: datavalues.errorValue,
          asistentesPag: asistentesPag,
          asistentesPagError:asistentesPagError
        );
      } on Exception catch (e) {
        print(e);
        yield state.copyWith();
      }
    }
    else if (event is AsistentesDisponiParticipantePagEvent) {
      try {
        SmartDialog.showLoading(isLoadingTemp: false,widget: Center(child: CircularProgressIndicator()));

        DataValues datavalues = await _asistenteRepo.asistentesDisponiblesParticipante(idParticipante: event.idParticipante, email: event.email, dni: event.dni, page: event.page);
        if (datavalues.statusCode != 404) {
          final valuesObject = (datavalues.modelValue!=null)? (datavalues.modelValue as AsistentePaginadoModel):null;
          state.asistenteDisponiPagParticipante!.results = [
            ...state.asistenteDisponiPagParticipante!.results!,
            ...valuesObject!.results!,
          ];
        }
        SmartDialog.dismiss();
        yield state.copyWith(
          listAsistenteParticipante: state.listAsistenteParticipante,
          listAsistenteParticipanteError: state.listAsistenteParticipanteError,
          asistenteDisponiPagParticipante: state.asistenteDisponiPagParticipante,
          asistenteDisponiPagParticipanteError: datavalues.errorValue,
          asistentesPag: asistentesPag,
          asistentesPagError: asistentesPagError,
        );
      } on Exception catch (_) {
        SmartDialog.dismiss();
        yield state.copyWith();
      } finally {
        await Future.delayed(Duration(seconds: 1));
        SmartDialog.dismiss();
      }
    }
    else if (event is RegistrarAsistenteParticipanteEvent) {
      try {
        SmartDialog.showLoading(isLoadingTemp: false, widget: Center(child: CircularProgressIndicator()));

        DataValues datavalues = await _asistenteRepo.registrarAsistenteParticipante(idParticipante: event.idParticipante, idAsistente: event.idAsistente);
        final valuesObject = (datavalues.modelValueList!=null)? (datavalues.modelValueList as List<AsistenteModel>):null;
        asistenteDisponiPagParticipante!.results = asistenteDisponiPagParticipante.results!.where((element) {
          return element.id != event.idAsistente;
        }).toList();
        SmartDialog.dismiss();
        yield state.copyWith(
          listAsistenteParticipante: valuesObject,
          listAsistenteParticipanteError: datavalues.errorValue,
          asistenteDisponiPagParticipante: asistenteDisponiPagParticipante,
          asistenteDisponiPagParticipanteError: asistenteDisponiPagParticipanteError,
          asistentesPagError: asistentesPagError,
          asistentesPag: asistentesPag,
        );
      } on Exception catch (_) {
        SmartDialog.dismiss();
        yield state.copyWith();
      } finally {
        await Future.delayed(Duration(seconds: 1));
        SmartDialog.dismiss();
      }
    }
    else if (event is EliminarAsistenteParticipanteEvent){
      try {
        SmartDialog.showLoading(isLoadingTemp: false, widget: Center(child: CircularProgressIndicator()));
        DataValues datavalues = await _asistenteRepo.eliminarAsistenteParticipante(idParticipante: event.idParticipante, idAsistente: event.idAsistente);
        if (datavalues.errorValue==null) {
          state.listAsistenteParticipante = state.listAsistenteParticipante!.where((element) =>element.id != event.idAsistente).toList();
        }
        SmartDialog.dismiss();
        yield state.copyWith(
          listAsistenteParticipante: state.listAsistenteParticipante,
          listAsistenteParticipanteError: datavalues.errorValue,
          asistentesPag: asistentesPag,
          asistentesPagError: asistentesPagError,
          asistenteDisponiPagParticipante: asistenteDisponiPagParticipante,
          asistenteDisponiPagParticipanteError: asistenteDisponiPagParticipanteError,
        );
      } on Exception catch (_) {
        SmartDialog.dismiss();
        yield state.copyWith();
      } finally {
        await Future.delayed(Duration(seconds: 1));
        SmartDialog.dismiss();
      }
    }
    else if (event is AsistentesEvent) {
      try {
        yield state.copyWith();
        DataValues datavalues = await _asistenteRepo.todosAsistentes(email: event.email, dni: event.dni, page: 1);
        final valuesObject = (datavalues.modelValue!=null)? (datavalues.modelValue as AsistentePaginadoModel):null;
        yield state.copyWith(
          asistentesPag: valuesObject,
          asistentesPagError: datavalues.errorValue
        );
      } on Exception catch (e) {
        print(e);
        yield state.copyWith();
      }
    }
    else if (event is AsistentesPagEvent) {
      try {
        SmartDialog.showLoading(isLoadingTemp: false,widget: Center(child: CircularProgressIndicator()));
        DataValues datavalues = await _asistenteRepo.todosAsistentes(email: event.email, dni: event.dni, page: event.page);

        if (datavalues.errorValue==null) {
          final valuesObject = (datavalues.modelValue!=null)? (datavalues.modelValue as AsistentePaginadoModel):null;
          state.asistentesPag!.results = [
            ...state.asistentesPag!.results!,
            ...valuesObject!.results!
          ];
        }
        SmartDialog.dismiss();
        yield state.copyWith(
            asistentesPag: state.asistentesPag,
            asistentesPagError: datavalues.errorValue
        );
      } on Exception catch (_) {
        SmartDialog.dismiss();
        yield state.copyWith();
      } finally {
        await Future.delayed(Duration(seconds: 1));
        SmartDialog.dismiss();
      }
    }
    else if (event is EliminarAsistenteEvent) {
      try {
        SmartDialog.showLoading(isLoadingTemp: false, widget: Center(child: CircularProgressIndicator()));
        DataValues datavalues = await _asistenteRepo.eliminarAsistente(idAsistente: event.idAsistente);
        if (datavalues.errorValue==null) {
          state.asistentesPag!.results = state.asistentesPag!.results!.where((item) => item.id != event.idAsistente).toList();
        }
        SmartDialog.dismiss();
        yield state.copyWith(
          asistentesPag: state.asistentesPag,
          asistentesPagError: datavalues.errorValue,
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