part of 'tarjetaModificacionBloc.dart';

@immutable
abstract class TarjetaModificacionEvent{}

class MisTarjetasDeModificacionEvent extends TarjetaModificacionEvent{
}

class TarjetasDeModificacionParticipanteEvent extends TarjetaModificacionEvent{
  final String idParticipante;
  TarjetasDeModificacionParticipanteEvent({required this.idParticipante});
}

class RegistrarTarjetaParticipanteEvent extends TarjetaModificacionEvent{
  final TarjetaModificacionModel tarjetaModifParticipante;
  RegistrarTarjetaParticipanteEvent({required this.tarjetaModifParticipante});
}

class EliminarTarjetaParticipanteEvent extends TarjetaModificacionEvent{
  final String idTarjetaModif;
  EliminarTarjetaParticipanteEvent({required this.idTarjetaModif });
}


class ActualizarTarjetaParticipanteEvent extends TarjetaModificacionEvent{
  final TarjetaModificacionModel tarjetaModifParticipante;
  ActualizarTarjetaParticipanteEvent({required this.tarjetaModifParticipante});
}
