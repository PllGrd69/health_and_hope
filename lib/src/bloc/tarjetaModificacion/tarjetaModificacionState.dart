part of 'tarjetaModificacionBloc.dart';


class TarjetaModificacionState {
  late List<TarjetaModificacionModel>? listTarjetaModificacion;
  late Map<dynamic, dynamic>? listTarjetaModificacionError;

  late List<TarjetaModificacionModel>? listTarjetaModificacionParticipante;
  late Map<dynamic, dynamic>? listTarjetaModificacionParticipanteError;

  TarjetaModificacionState({
    this.listTarjetaModificacion,
    this.listTarjetaModificacionError,
    this.listTarjetaModificacionParticipante,
    this.listTarjetaModificacionParticipanteError
  });

  TarjetaModificacionState copyWith({
    List<TarjetaModificacionModel>? listTarjetaModificacion,
    Map<dynamic, dynamic>? listTarjetaModificacionError,
    List<TarjetaModificacionModel>? listTarjetaModificacionParticipante,
    Map<dynamic, dynamic>? listTarjetaModificacionParticipanteError
  }) {
    return TarjetaModificacionState(
      listTarjetaModificacion: listTarjetaModificacion,
      listTarjetaModificacionError: listTarjetaModificacionError,
      listTarjetaModificacionParticipante: listTarjetaModificacionParticipante,
      listTarjetaModificacionParticipanteError: listTarjetaModificacionParticipanteError
    );
  }

  TarjetaModificacionState initState() => TarjetaModificacionState();
}