import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:health_and_hope/src/models/baseModel/dataValues.dart';
import 'package:health_and_hope/src/models/models/actividadAyudaModel.dart';
import 'package:health_and_hope/src/repositories/actividadAyudaRepository.dart';

part 'actividadAyudaEvent.dart';
part 'actividadAyudaState.dart';


class ActividadAyudaBloc extends Bloc<ActividadAyudaEvent, ActividadAyudaState> {
  final ActividadAyudaRepository _actividadesAyuda = ActividadAyudaRepository();

  ActividadAyudaBloc(): super(ActividadAyudaState().initState());

  @override
  Stream<ActividadAyudaState> mapEventToState(ActividadAyudaEvent event) async* {
    if (event is MisActividadesAyudaEvent){
      try {
        yield state.copyWith();
        DataValues datavalues = await _actividadesAyuda.misActividadesAyuda(uuidActividad: event.uuidActividad);
        yield state.copyWith(
            listActividadesAyuda: datavalues.modelValueList!=null?
            (datavalues.modelValueList as List<ActividadAyudaModel>):null,
            listActividadesAyudaError: datavalues.errorValue
        );
      } on Exception catch (e) {
        print(e);
        yield state.copyWith();
      }
    }
  }

}