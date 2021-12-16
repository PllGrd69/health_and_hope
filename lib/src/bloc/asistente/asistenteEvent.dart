part of 'asistenteBloc.dart';

@immutable
abstract class AsistenteEvent{}

class AsistentesParticipanteEvent extends AsistenteEvent{
  final String idParticipante;
  AsistentesParticipanteEvent({required this.idParticipante});
}


class AsistentesDisponiParticipanteEvent extends AsistenteEvent{
  final String idParticipante;
  final String email;
  final String dni;
  AsistentesDisponiParticipanteEvent({
    required this.idParticipante,
    required this.email,
    required this.dni
  });
}

class AsistentesDisponiParticipantePagEvent extends AsistenteEvent{

  final String idParticipante;
  final String email;
  final String dni;
  final int page;

  AsistentesDisponiParticipantePagEvent({
    required this.idParticipante,
    required this.email,
    required this.dni,
    required this.page,
  });

}

class RegistrarAsistenteParticipanteEvent extends AsistenteEvent{
  final String idParticipante;
  final String idAsistente;
  RegistrarAsistenteParticipanteEvent({required this.idParticipante, required this.idAsistente});
}

class EliminarAsistenteParticipanteEvent extends AsistenteEvent{
  final String idParticipante;
  final String idAsistente;
  EliminarAsistenteParticipanteEvent({required this.idParticipante, required this.idAsistente});
}

class AsistentesEvent extends AsistenteEvent{
  final String email;
  final String dni;
  AsistentesEvent({
    required this.email,
    required this.dni
  });
}

class AsistentesPagEvent extends AsistenteEvent{
  final String email;
  final String dni;
  final int page;

  AsistentesPagEvent({
    required this.email,
    required this.dni,
    required this.page,
  });

}

class EliminarAsistenteEvent extends AsistenteEvent{
  final String idAsistente;
  EliminarAsistenteEvent({required this.idAsistente});
}