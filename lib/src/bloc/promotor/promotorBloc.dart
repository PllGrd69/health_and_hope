import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:health_and_hope/src/models/baseModel/models.dart';
import 'package:health_and_hope/src/repositories/promotorRepository.dart';

part 'promotorState.dart';
part 'promotorEvent.dart';

class PromotorBloc extends Bloc<PromotorEvent, PromotorState> {
  final PromotorRepository _promotorRepo = PromotorRepository();

  PromotorBloc() : super(PromotorState().initState());

  @override
  Stream<PromotorState> mapEventToState(PromotorEvent event) async* {
    if (event is PromotoresParticipanteEvent) {
      try {
        yield state.copyWith();
        DataValues datavalues = await _promotorRepo.promotoresParticipante(idParticipante: event.idParticipante);
        final valuesObject = (datavalues.modelValueList!=null)? (datavalues.modelValueList as List<PromotorParticipanteModel>):null;
        yield state.copyWith(
            listPromotorParticipante: valuesObject,
            listPromotorParticipanteError: datavalues.errorValue
        );
      } on Exception catch (e) {
        print(e);
        yield state.copyWith();
      }
    }
    else if (event is RegistrarPromotoresParticipanteEvent) {
      try {
        SmartDialog.showLoading(isLoadingTemp: false, widget: Center(child: CircularProgressIndicator()));
        DataValues datavalues = await _promotorRepo.registrarPromotorParticipante(idParticipante: event.idParticipante, idPromotorParticipante: event.idPromotorParticipante);
        final valuesObject = (datavalues.modelValueList!=null)? (datavalues.modelValueList as List<PromotorParticipanteModel>):null;
        yield state.copyWith(
            listPromotorParticipante: valuesObject,
            listPromotorParticipanteError: datavalues.errorValue
        );
        await Future.delayed(Duration(milliseconds: 500));
        SmartDialog.dismiss();
      } on Exception catch (_) {
        yield state.copyWith();
        await Future.delayed(Duration(milliseconds: 500));
        SmartDialog.dismiss();
      } finally {
        await Future.delayed(Duration(seconds: 1));
        SmartDialog.dismiss();
      }
    }
    else if (event is EliminarPromotorParticipanteEvent) {
      SmartDialog.showLoading(isLoadingTemp: false, widget: Center(child: CircularProgressIndicator()));
      try {
        DataValues datavalues = await _promotorRepo.eliminarPromotorParticipante(idPromotorParticipante: event.idPromotorParticipante);
        if (datavalues.errorValue==null) {
          state.listPromotorParticipante = state.listPromotorParticipante!.where((element) => element.id != event.idPromotorParticipante).toList();
        }
        SmartDialog.dismiss();
        yield state.copyWith(
          listPromotorParticipante: state.listPromotorParticipante,
          listPromotorParticipanteError: datavalues.errorValue
        );
      } on Exception catch (_) {
        SmartDialog.dismiss();
        yield state.copyWith();
      } finally{
        await Future.delayed(Duration(seconds: 1));
        SmartDialog.dismiss();
      }
    }
  }
}