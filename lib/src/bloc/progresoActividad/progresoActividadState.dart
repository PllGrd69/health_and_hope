part of 'progresoActividadBloc.dart';

class ProgroseActividadState {
  late List<ProgresoActividadDiarioModel>? listProgresoActividad;
  late List<ProgresoActividadDiarioModel>? listTarjetaProgresoActividad;
  late Map<dynamic, dynamic>? listTarjetaProgresoActividadError;
  late Map<dynamic, dynamic>? listProgresoActividadError;

  ProgroseActividadState({
    this.listProgresoActividad,
    this.listProgresoActividadError,
    this.listTarjetaProgresoActividad,
    this.listTarjetaProgresoActividadError,
  });

  ProgroseActividadState copyWith({
    List<ProgresoActividadDiarioModel>? listProgresoActividad,
    Map<dynamic, dynamic>? listProgresoActividadError,
    List<ProgresoActividadDiarioModel>? listTarjetaProgresoActividad,
    Map<dynamic, dynamic>? listTarjetaProgresoActividadError,
  }) {
    return ProgroseActividadState(
      listProgresoActividad: listProgresoActividad,
      listProgresoActividadError: listProgresoActividadError,
      listTarjetaProgresoActividad: listTarjetaProgresoActividad,
        listTarjetaProgresoActividadError: listTarjetaProgresoActividadError,
    );
  }

  ProgroseActividadState initState() => ProgroseActividadState();

}