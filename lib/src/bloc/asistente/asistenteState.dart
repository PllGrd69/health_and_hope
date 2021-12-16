part of 'asistenteBloc.dart';


class AsistenteState {

  late List<AsistenteModel>? listAsistenteParticipante;
  late Map<dynamic, dynamic>? listAsistenteParticipanteError;

  late AsistentePaginadoModel? asistenteDisponiPagParticipante;
  late Map<dynamic, dynamic>? asistenteDisponiPagParticipanteError;

  late AsistentePaginadoModel? asistentesPag;
  late Map<dynamic, dynamic>? asistentesPagError;

  AsistenteState({
    this.listAsistenteParticipante,
    this.listAsistenteParticipanteError,
    this.asistenteDisponiPagParticipante,
    this.asistenteDisponiPagParticipanteError,
    this.asistentesPag,
    this.asistentesPagError,
  });

  AsistenteState copyWith({
    List<AsistenteModel>? listAsistenteParticipante,
    Map<dynamic, dynamic>? listAsistenteParticipanteError,
    AsistentePaginadoModel? asistenteDisponiPagParticipante,
    Map<dynamic, dynamic>? asistenteDisponiPagParticipanteError,
    AsistentePaginadoModel? asistentesPag,
    Map<dynamic, dynamic>? asistentesPagError,
  }) {
    return AsistenteState(
      listAsistenteParticipante: listAsistenteParticipante,
      listAsistenteParticipanteError: listAsistenteParticipanteError,
      asistenteDisponiPagParticipante: asistenteDisponiPagParticipante,
      asistenteDisponiPagParticipanteError: asistenteDisponiPagParticipanteError,
      asistentesPag: asistentesPag,
      asistentesPagError: asistentesPagError,
    );
  }

  AsistenteState initState() => AsistenteState();
}