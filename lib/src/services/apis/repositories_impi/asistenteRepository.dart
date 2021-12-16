
import 'package:health_and_hope/src/models/baseModel/dataValues.dart';
import 'package:health_and_hope/src/services/apis/data_source/remote/actividadAyudaApi.dart';
import 'package:health_and_hope/src/services/apis/data_source/remote/asistenteApi.dart';
import 'package:health_and_hope/src/services/apis/data_source/remote/departamentoApi.dart';
import 'package:health_and_hope/src/services/apis/repositories/actividadAyudaRepository.dart';
import 'package:health_and_hope/src/services/apis/repositories/asistenteRepository.dart';
import 'package:health_and_hope/src/services/apis/repositories/departamentoRepository.dart';

class AsistenteRepositoryApiIm implements AsistenteRepositoryApi {
  final AsistenteApi _api;
  AsistenteRepositoryApiIm(this._api);

  @override
  Future<DataValues> asistentesParticipante({required String idParticipante}) async {
    return await this._api.asistentesParticipante(idParticipante: idParticipante);
  }

  @override
  Future<DataValues> asistentesDisponiblesParticipante({required String idParticipante, required String email, required String dni, required int page}) async {
    return await this._api.asistentesDisponiblesParticipante(idParticipante: idParticipante, email: email, dni: dni, page: page);
  }

  @override
  Future<DataValues> registrarAsistenteParticipante({required String idParticipante, required String idAsistente}) async {
    return await this._api.registrarAsistenteParticipante(idParticipante: idParticipante, idAsistente: idAsistente);
  }

  @override
  Future<DataValues> eliminarAsistenteParticipante({required String idParticipante, required String idAsistente}) async {
    return await _api.eliminarAsistenteParticipante(idParticipante: idParticipante, idAsistente: idAsistente);
  }

  @override
  Future<DataValues> todosAsistentes({required String email, required String dni, required int page}) async {
    return await _api.todosAsistentes(email: email, dni: dni, page: page);
  }

  @override
  Future<DataValues> eliminarAsistente({required String idAsistente}) async {
    return await _api.eliminarAsistente(idAsistente: idAsistente);

  }

}