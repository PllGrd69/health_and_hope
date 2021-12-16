part of 'personalDepartamentoBloc.dart';

@immutable
abstract class PersonalDepartamentoEvent{}

class AllPersonalDepartamentoEvent extends PersonalDepartamentoEvent{
  final String uuidDepartamento;
  final int page;
  AllPersonalDepartamentoEvent({
    required this.uuidDepartamento,
    required this.page
  });
}

class AllPersonalPaginadoEvent extends PersonalDepartamentoEvent{
  final int page;
  AllPersonalPaginadoEvent({
    required this.page
  });
}

class RegistrarPersonalDepartamentoEvent extends PersonalDepartamentoEvent {
  final String uuidDepartamento;
  final String uuidPersonal;
  RegistrarPersonalDepartamentoEvent({required this.uuidDepartamento, required this.uuidPersonal});
}


class EliminarPersonalDepEvent extends PersonalDepartamentoEvent {
  final String uuidPersonalDep;
  EliminarPersonalDepEvent({required this.uuidPersonalDep});
}

class AllPersonalDepDisponibleEvent extends PersonalDepartamentoEvent {
  final String idDepartamento;
  AllPersonalDepDisponibleEvent({required this.idDepartamento});
}


class PersonalDisponibleParticipanteEvent extends PersonalDepartamentoEvent{
  final String idParticipante;
  final String dni;
  final String email;
  PersonalDisponibleParticipanteEvent({
    required this.idParticipante,
    required this.dni,
    required this.email,
  });
}


class PersonalDisponibleParticipanteNoRefreshEvent extends PersonalDepartamentoEvent{
  final String idParticipante;
  final String dni;
  final String email;
  PersonalDisponibleParticipanteNoRefreshEvent({
    required this.idParticipante,
    required this.dni,
    required this.email,
  });
}

// class QuitarPersonalDisponibleParticipanteEvent extends PersonalDepartamentoEvent{
//   final String idPersonal;
//   QuitarPersonalDisponibleParticipanteEvent({
//     required this.idPersonal,
//   });
// }


class PersonalDisponibleParticipantePagEvent extends PersonalDepartamentoEvent{
  final String idParticipante;
  final String dni;
  final String email;
  final int page;

  PersonalDisponibleParticipantePagEvent({
    required this.idParticipante,
    required this.dni,
    required this.email,
    required this.page,
  });

}
