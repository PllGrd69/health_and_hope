
import 'package:health_and_hope/src/models/baseModel/dataValues.dart';
import 'package:health_and_hope/src/services/apis/data_source/remote/actividadAyudaApi.dart';
import 'package:health_and_hope/src/services/apis/data_source/remote/asistenteApi.dart';
import 'package:health_and_hope/src/services/apis/data_source/remote/departamentoApi.dart';
import 'package:health_and_hope/src/services/apis/data_source/remote/protomotorApi.dart';
import 'package:health_and_hope/src/services/apis/repositories/actividadAyudaRepository.dart';
import 'package:health_and_hope/src/services/apis/repositories/asistenteRepository.dart';
import 'package:health_and_hope/src/services/apis/repositories/departamentoRepository.dart';
import 'package:health_and_hope/src/services/apis/repositories/promotorRepository.dart';

class PromotorRepositoryApiIm implements PromotorRepositoryApi {
  final PromotorApi _api;
  PromotorRepositoryApiIm(this._api);

  @override
  Future<DataValues> promotoresParticipante({required String idParticipante}) async {
    return await this._api.promotoresParticipante(idParticipante: idParticipante);
  }

  @override
  Future<DataValues> registrarPromotorParticipante({required String idParticipante, required String idPromotorParticipante}) async {
    return await this._api.registrarPromotorParticipante(idParticipante: idParticipante, idPromotorParticipante: idPromotorParticipante);
  }

  @override
  Future<DataValues> eliminarPromotorParticipante({required String idPromotorParticipante}) async {
    return await this._api.eliminarPromotorParticipante(idPromotorParticipante: idPromotorParticipante);
  }

}