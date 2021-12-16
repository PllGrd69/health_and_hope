part of 'promotorBloc.dart';



class PromotorState {

  late List<PromotorParticipanteModel>? listPromotorParticipante;
  late Map<dynamic, dynamic>? listPromotorParticipanteError;

  PromotorState({this.listPromotorParticipante, this.listPromotorParticipanteError});

  PromotorState copyWith({List<PromotorParticipanteModel>? listPromotorParticipante, Map<dynamic, dynamic>? listPromotorParticipanteError}) {
    return PromotorState(
      listPromotorParticipante: listPromotorParticipante,
      listPromotorParticipanteError: listPromotorParticipanteError,
    );
  }

  PromotorState initState() => PromotorState();

}