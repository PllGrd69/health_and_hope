
import 'package:health_and_hope/src/models/baseModel/dataValues.dart';
import 'package:health_and_hope/src/services/apis/data_source/remote/actividadAyudaApi.dart';
import 'package:health_and_hope/src/services/apis/data_source/remote/personalDepartamentoApi.dart';
import 'package:health_and_hope/src/services/apis/repositories/actividadAyudaRepository.dart';
import 'package:health_and_hope/src/services/apis/repositories/personalDepartamentoRepository.dart';

class PersonalDepartamentoRepositoryApiIm implements PersonalDepartamentoRepositoryApi {
  final PersonalDepartamentoApi _api;
  PersonalDepartamentoRepositoryApiIm(this._api);


  @override
  Future<DataValues> allPersonalDepartamento({required String uuidDepartamento,required int page}) async{
    return await this._api.allPersonalDepartamento(uuidDepartamento: uuidDepartamento, page: page);
  }

  @override
  Future<DataValues> registrarPersonalDepartamento({required String uuidDepartamento, required String uuidPersonal}) async {
    return await this._api.registrarPersonalDepartamento(uuidDepartamento: uuidDepartamento, uuidPersonal: uuidPersonal);
  }

  @override
  Future<DataValues> eliminarPersonalDep({required String uuidPersonalDep}) async {
    return await this._api.eliminarPersonalDep(uuidPersonalDep: uuidPersonalDep);
  }

  @override
  Future<DataValues> allPersonalDepDisponible({required String idDepartamento}) async {
    return await this._api.allPersonalDepDisponible(idDepartamento: idDepartamento);
  }

  @override
  Future<DataValues> personalDisponibleParticipante({required String idParticipante, required String dni, required String email, required int page}) async {
    return await this._api.personalDisponibleParticipante(idParticipante: idParticipante, dni: dni, email: email, page: page);
  }


}