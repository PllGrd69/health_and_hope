part of 'participanteBloc.dart';



class ParticipanteState {
  late ParticipantePaginadoModel? participantesPaginado;
  late Map<dynamic, dynamic>? participantesPaginadoError;
  ParticipanteState({
    this.participantesPaginado,
    this.participantesPaginadoError,
  });
  ParticipanteState copyWith({
    ParticipantePaginadoModel? participantesPaginado,
    Map<dynamic, dynamic>? participantesPaginadoError,
  }) => ParticipanteState(
    participantesPaginado: participantesPaginado,
    participantesPaginadoError: participantesPaginadoError,
  );
  ParticipanteState initState()=> ParticipanteState();
}