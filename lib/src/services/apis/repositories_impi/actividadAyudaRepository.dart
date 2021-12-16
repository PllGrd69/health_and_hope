
import 'package:health_and_hope/src/models/baseModel/dataValues.dart';
import 'package:health_and_hope/src/services/apis/data_source/remote/actividadAyudaApi.dart';
import 'package:health_and_hope/src/services/apis/repositories/actividadAyudaRepository.dart';

class ActividadAyudaRepositoryApiIm implements ActividadAyudaRepositoryApi {
  final ActividadAyudaApi _api;
  ActividadAyudaRepositoryApiIm(this._api);

  @override
  Future<DataValues> misActividadesAyuda({required String uuidActividad}) async {
    return await this._api.misActividadesAyuda(uuidActividad: uuidActividad);
  }


}