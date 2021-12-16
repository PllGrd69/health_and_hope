
import 'package:health_and_hope/src/models/baseModel/dataValues.dart';
import 'package:health_and_hope/src/services/apis/data_source/remote/actividadAyudaApi.dart';
import 'package:health_and_hope/src/services/apis/data_source/remote/departamentoApi.dart';
import 'package:health_and_hope/src/services/apis/repositories/actividadAyudaRepository.dart';
import 'package:health_and_hope/src/services/apis/repositories/departamentoRepository.dart';

class DepartamentoRepositoryApiIm implements DepartamentoRepositoryApi {
  final DepartamentoApi _api;
  DepartamentoRepositoryApiIm(this._api);


  @override
  Future<DataValues> allDepartamentos() async {
    return await this._api.allDepartamentos();
  }

  @override
  Future<DataValues> crearDepartamento({required String nombre}) async {
    return await this._api.crearDepartamento(nombre: nombre);
  }


}