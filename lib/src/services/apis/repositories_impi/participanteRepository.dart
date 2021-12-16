
import 'package:health_and_hope/src/models/baseModel/dataValues.dart';
import 'package:health_and_hope/src/services/apis/data_source/remote/actividadAyudaApi.dart';
import 'package:health_and_hope/src/services/apis/data_source/remote/departamentoApi.dart';
import 'package:health_and_hope/src/services/apis/data_source/remote/participanteApi.dart';
import 'package:health_and_hope/src/services/apis/data_source/remote/personalApi.dart';
import 'package:health_and_hope/src/services/apis/repositories/participanteRepository.dart';
import 'package:health_and_hope/src/services/apis/repositories/personalRepository.dart';
import 'package:health_and_hope/src/services/apis/repositories/actividadAyudaRepository.dart';
import 'package:health_and_hope/src/services/apis/repositories/departamentoRepository.dart';

class ParticipanteRepositoryApiIm implements ParticipanteRepositoryApi {
  final ParticipanteApi _api;
  ParticipanteRepositoryApiIm(this._api);

  @override
  Future<DataValues> allParticipantes({required int page, required String email, required String dni}) async {
    return await this._api.allParticipantes(page: page, email: email, dni: dni);
  }

  @override
  Future<DataValues> eliminarParticipante({required String idParticipante}) async {
    return await this._api.eliminarParticipante(idParticipante: idParticipante);
  }

}