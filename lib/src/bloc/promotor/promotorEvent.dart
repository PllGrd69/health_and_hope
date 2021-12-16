part of 'promotorBloc.dart';

@immutable
abstract class PromotorEvent{}

class PromotoresParticipanteEvent extends PromotorEvent{
  final String idParticipante;
  PromotoresParticipanteEvent({required this.idParticipante});
}

class RegistrarPromotoresParticipanteEvent extends PromotorEvent{
  final String idParticipante;
  final String idPromotorParticipante;
  RegistrarPromotoresParticipanteEvent({required this.idParticipante, required this.idPromotorParticipante});
}

class EliminarPromotorParticipanteEvent extends PromotorEvent{
  final String idPromotorParticipante;
  EliminarPromotorParticipanteEvent({required this.idPromotorParticipante});
}