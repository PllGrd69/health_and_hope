part of 'participanteBloc.dart';

@immutable
abstract class ParticipanteEvent{}

class AllParticipantesEvent extends ParticipanteEvent{
  final int page;
  final String email;
  final String dni;
  AllParticipantesEvent({required this.page, required this.email, required this.dni});
}

class AllParticipantesPaginadoEvent extends ParticipanteEvent{
  final int page;
  final String email;
  final String dni;
  AllParticipantesPaginadoEvent({required this.page, required this.email, required this.dni});
}

class EliminarParticipanteEvent extends ParticipanteEvent{
  final String idParticipante;
  EliminarParticipanteEvent({required this.idParticipante});
}

