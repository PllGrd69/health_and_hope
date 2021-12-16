
import 'package:health_and_hope/src/models/baseModel/dataValues.dart';
import 'package:health_and_hope/src/services/apis/data_source/remote/actividadAyudaApi.dart';
import 'package:health_and_hope/src/services/apis/data_source/remote/departamentoApi.dart';
import 'package:health_and_hope/src/services/apis/data_source/remote/personalApi.dart';
import 'package:health_and_hope/src/services/apis/repositories/personalRepository.dart';
import 'package:health_and_hope/src/services/apis/repositories/actividadAyudaRepository.dart';
import 'package:health_and_hope/src/services/apis/repositories/departamentoRepository.dart';

class PersonalRepositoryApiIm implements PersonalRepositoryApi {
  final PersonalApi _api;
  PersonalRepositoryApiIm(this._api);

  @override
  Future<DataValues> allPersonal() async {
    return await this._api.allPersonal();
  }

  @override
  Future<DataValues> listaPersonal({required String dni, required String email, required int page}) async {
    return await this._api.listaPersonal(dni: dni, email: email, page: page);
  }

  @override
  Future<DataValues> eliminarPersonal({required String idPersonal}) async {
    return await this._api.eliminarPersonal(idPersonal: idPersonal);
  }

}