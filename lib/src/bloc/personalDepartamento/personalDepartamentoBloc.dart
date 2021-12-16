import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:health_and_hope/src/models/baseModel/models.dart';
import 'package:health_and_hope/src/repositories/personalDepartamentoRepository.dart';


part 'personalDepartamentoEvent.dart';
part 'personalDepartamentoState.dart';


class PersonalDepartamentoBloc extends Bloc<PersonalDepartamentoEvent, PersonalDepartamentoState> {
  final PersonalDepartamentoRepository _personalDepRepo = PersonalDepartamentoRepository();

  PersonalDepartamentoBloc() : super(PersonalDepartamentoState().initState());

  @override
  Stream<PersonalDepartamentoState> mapEventToState(PersonalDepartamentoEvent event) async* {
    if (event is AllPersonalDepartamentoEvent) {
      try {
        final listPersonalDepDisponible = state.listPersonalDepDisponible;
        final listPersonalDepDisponibleError = state.listPersonalDepDisponibleError;

        yield state.copyWith();
        DataValues datavalues = await _personalDepRepo.allPersonalDepartamento(
            uuidDepartamento: event.uuidDepartamento,
            page: event.page
        );
        final object = (datavalues.modelValue!=null)?(datavalues.modelValue as PersonalDepartamentoPaginadoModel) : null;
        yield state.copyWith(
          personalDepartamentoPaginado: object,
          personalDepartamentoPaginadoError: datavalues.errorValue,
          listPersonalDepDisponible: listPersonalDepDisponible,
          listPersonalDepDisponibleError: listPersonalDepDisponibleError
        );
      } on Exception catch (e) {
        print(e);
        yield state.copyWith();
      }
    }
    else if (event is AllPersonalPaginadoEvent) {
      SmartDialog.showLoading(isLoadingTemp: false,widget: Center(child: CircularProgressIndicator()));
      try {
        final uuidDepartamento = state.personalDepartamentoPaginado!.results![0].departamento!.id??'departamento';
        DataValues datavalues = await _personalDepRepo.allPersonalDepartamento(uuidDepartamento: uuidDepartamento, page: event.page);
        final object = (datavalues.modelValue!=null)?(datavalues.modelValue as PersonalDepartamentoPaginadoModel) : null;

        state.personalDepartamentoPaginado!.results = [
          ...state.personalDepartamentoPaginado!.results!,
          ...object!.results!,
        ];

        yield state.copyWith(
          personalDepartamentoPaginado: state.personalDepartamentoPaginado,
          personalDepartamentoPaginadoError: datavalues.errorValue,
          listPersonalDepDisponible: state.listPersonalDepDisponible,
          listPersonalDepDisponibleError: state.listPersonalDepDisponibleError
        );

      } on Exception catch (e) {
        print(e);
        yield state.copyWith();
      } finally {
        SmartDialog.dismiss();
      }
    }
    else if (event is RegistrarPersonalDepartamentoEvent) {
      try {
        SmartDialog.showLoading(isLoadingTemp: false,widget: Center(child: CircularProgressIndicator()));
        DataValues datavalues = await _personalDepRepo
            .registrarPersonalDepartamento(
            uuidDepartamento: event.uuidDepartamento,
            uuidPersonal: event.uuidPersonal
        );
        DataValues datavaluesNewValues = await _personalDepRepo.allPersonalDepartamento(
            uuidDepartamento: event.uuidDepartamento,
            page: 1
        );
        final listadoPersonaNew = state.listPersonalDepDisponible!.where((e) => e.id != (event).uuidPersonal).toList();

        final object = (datavaluesNewValues.modelValue!=null)?(datavaluesNewValues.modelValue as PersonalDepartamentoPaginadoModel) : null;
        yield state.copyWith(
          personalDepartamentoPaginado: object,
          personalDepartamentoPaginadoError: datavalues.errorValue,
          listPersonalDepDisponible: listadoPersonaNew,
          listPersonalDepDisponibleError: state.listPersonalDepDisponibleError
        );
      } on Exception catch (e) {
        print(e);
        yield state.copyWith();
      } finally {
        SmartDialog.dismiss();
      }
    }
    else if (event is AllPersonalDepDisponibleEvent) {
      try {
        final personalDepartamentoPaginado = state.personalDepartamentoPaginado;
        final personalDepartamentoPaginadoError = state.personalDepartamentoPaginadoError;
        yield state.copyWith();
        DataValues datavalues = await _personalDepRepo.allPersonalDepDisponible(idDepartamento: event.idDepartamento);
        final valuesList = (datavalues.modelValueList !=null)? (datavalues.modelValueList as List<PersonalModel>):null;
        yield state.copyWith(
          listPersonalDepDisponible: valuesList,
          listPersonalDepDisponibleError: datavalues.errorValue,
          personalDepartamentoPaginado: personalDepartamentoPaginado,
          personalDepartamentoPaginadoError:  personalDepartamentoPaginadoError
        );
      } on Exception catch (e) {
        print(e);
        yield state.copyWith();
      }
    }
    else if (event is EliminarPersonalDepEvent) {
      SmartDialog.showLoading(isLoadingTemp: false,widget: Center(child: CircularProgressIndicator()));
      try {
        DataValues datavalues = await _personalDepRepo.eliminarPersonalDep(uuidPersonalDep: event.uuidPersonalDep);
        if (datavalues.errorValue==null) {
          final resultNew = state.personalDepartamentoPaginado!.results!.where((element)=>element.id! != event.uuidPersonalDep).toList();
          // Error
          final personal = await _personalDepRepo.allPersonalDepDisponible(idDepartamento: state.personalDepartamentoPaginado!.results![0].departamento!.id!);
          state.listPersonalDepDisponible = (personal.modelValueList !=null)? (personal.modelValueList as List<PersonalModel>):null;
          state.listPersonalDepDisponibleError = personal.errorValue;
          state.personalDepartamentoPaginado!.results = resultNew;
        }
        yield state.copyWith(
          personalDepartamentoPaginado: state.personalDepartamentoPaginado,
          personalDepartamentoPaginadoError: datavalues.errorValue,
          listPersonalDepDisponibleError: state.listPersonalDepDisponibleError,
          listPersonalDepDisponible: state.listPersonalDepDisponible
        );
      } on Exception catch (e) {
        print(e);
        yield state.copyWith();
      } finally {
        SmartDialog.dismiss();
      }
    }
    else if (event is PersonalDisponibleParticipanteEvent) {
      try {
        final listPersonalDepDisponible = state.listPersonalDepDisponible;
        final listPersonalDepDisponibleError = state.listPersonalDepDisponibleError;
        final personalDepartamentoPaginado = state.personalDepartamentoPaginado;
        final personalDepartamentoPaginadoError = state.listPersonalDepDisponibleError;

        yield state.copyWith();
        DataValues datavalues = await _personalDepRepo.personalDisponibleParticipante(
          idParticipante: event.idParticipante,
          dni: event.dni,
          email: event.email,
          page: 1
        );

        final object = (datavalues.modelValue!=null)?(datavalues.modelValue as PersonalDepartamentoPaginadoModel) : null;
        yield state.copyWith(
          personalDepartamentoPaginado: personalDepartamentoPaginado,
          personalDepartamentoPaginadoError: personalDepartamentoPaginadoError,
          listPersonalDepDisponible: listPersonalDepDisponible,
          listPersonalDepDisponibleError: listPersonalDepDisponibleError,
          personalDeparDisponiblePag: object,
          personalDeparDisponiblePagError: datavalues.errorValue
        );
      } on Exception catch (e) {
        print(e);
        yield state.copyWith();
      }
    }
    else if (event is PersonalDisponibleParticipanteNoRefreshEvent) {
      try {
        final listPersonalDepDisponible = state.listPersonalDepDisponible;
        final listPersonalDepDisponibleError = state.listPersonalDepDisponibleError;
        final personalDepartamentoPaginado = state.personalDepartamentoPaginado;
        final personalDepartamentoPaginadoError = state.listPersonalDepDisponibleError;

        DataValues datavalues = await _personalDepRepo.personalDisponibleParticipante(
            idParticipante: event.idParticipante,
            dni: event.dni,
            email: event.email,
            page: 1
        );

        final object = (datavalues.modelValue!=null)?(datavalues.modelValue as PersonalDepartamentoPaginadoModel) : null;
        yield state.copyWith(
            personalDepartamentoPaginado: personalDepartamentoPaginado,
            personalDepartamentoPaginadoError: personalDepartamentoPaginadoError,
            listPersonalDepDisponible: listPersonalDepDisponible,
            listPersonalDepDisponibleError: listPersonalDepDisponibleError,
            personalDeparDisponiblePag: object,
            personalDeparDisponiblePagError: datavalues.errorValue
        );
      } on Exception catch (e) {
        print(e);
        yield state.copyWith();
      }
    }
    else if (event is PersonalDisponibleParticipantePagEvent) {
      try {
        SmartDialog.showLoading(
          isLoadingTemp: false,
          widget: Center(child: CircularProgressIndicator()),
        );
        final listPersonalDepDisponible = state.listPersonalDepDisponible;
        final listPersonalDepDisponibleError = state.listPersonalDepDisponibleError;
        final personalDepartamentoPaginado = state.personalDepartamentoPaginado;
        final personalDepartamentoPaginadoError = state.listPersonalDepDisponibleError;

        DataValues datavalues = await _personalDepRepo.personalDisponibleParticipante(
            idParticipante: event.idParticipante,
            dni: event.dni,
            email: event.email,
            page: event.page
        );

        if (datavalues.statusCode != 404) {
          final object = (datavalues.modelValue!=null)?(datavalues.modelValue as PersonalDepartamentoPaginadoModel) : null;
          state.personalDeparDisponiblePag!.results = [
            ...state.personalDeparDisponiblePag!.results!,
            ...object!.results!,
          ];
        }
        SmartDialog.dismiss();
        yield state.copyWith(
            personalDepartamentoPaginado: personalDepartamentoPaginado,
            personalDepartamentoPaginadoError: personalDepartamentoPaginadoError,
            listPersonalDepDisponible: listPersonalDepDisponible,
            listPersonalDepDisponibleError: listPersonalDepDisponibleError,
            personalDeparDisponiblePag: state.personalDeparDisponiblePag,
            personalDeparDisponiblePagError: datavalues.errorValue
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