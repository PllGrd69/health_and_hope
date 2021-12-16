import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:health_and_hope/src/models/baseModel/models.dart';
import 'package:health_and_hope/src/repositories/participanteRepository.dart';

part 'participanteEvent.dart';
part 'participanteState.dart';


class ParticipanteBloc extends Bloc<ParticipanteEvent, ParticipanteState> {
  final ParticipanteRepository _psrticipanteRepo = ParticipanteRepository();
  ParticipanteBloc(): super(ParticipanteState().initState());

  @override
  Stream<ParticipanteState> mapEventToState(ParticipanteEvent event)  async* {
    if (event is AllParticipantesEvent){
      try {
        yield state.copyWith();
        DataValues datavalues = await _psrticipanteRepo.allParticipantes(page: 1, email: event.email, dni: event.dni);
        final valueParticpantes = datavalues.modelValue!=null?(datavalues.modelValue as ParticipantePaginadoModel):null;

        yield state.copyWith(
            participantesPaginado: valueParticpantes,
            participantesPaginadoError: datavalues.errorValue
        );
      } on Exception catch (_) {
        yield state.copyWith();
      }
    }
    else if (event is AllParticipantesPaginadoEvent) {
      SmartDialog.showLoading(isLoadingTemp: false, widget: Center(child: CircularProgressIndicator()));
      try {
        DataValues datavalues = await _psrticipanteRepo.allParticipantes(page: event.page, email: event.email, dni: event.dni);
        if (datavalues.statusCode != 404) {
          final object = (datavalues.modelValue!=null)?(datavalues.modelValue as ParticipantePaginadoModel) : null;
          state.participantesPaginado!.results = [...state.participantesPaginado!.results!, ...object!.results!];
        }
        SmartDialog.dismiss();
        yield state.copyWith(participantesPaginado: state.participantesPaginado, participantesPaginadoError: datavalues.errorValue);
      } on Exception catch (_) {
        SmartDialog.dismiss();
        yield state.copyWith();
      } finally {
        await Future.delayed(Duration(seconds: 1));
        SmartDialog.dismiss();
      }
    }
    else if (event is EliminarParticipanteEvent){
      try {
        SmartDialog.showLoading(isLoadingTemp: false, widget: Center(child: CircularProgressIndicator()));

        DataValues datavalues = await _psrticipanteRepo.eliminarParticipante(idParticipante: event.idParticipante);

        if(datavalues.errorValue==null){
          state.participantesPaginado!.results = state.participantesPaginado!.results!.where((item) => item.id!=event.idParticipante).toList();
        }
        SmartDialog.dismiss();
        yield state.copyWith(
            participantesPaginado: state.participantesPaginado,
            participantesPaginadoError: datavalues.errorValue
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