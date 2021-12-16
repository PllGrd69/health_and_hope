
import 'package:health_and_hope/src/models/baseModel/dataValues.dart';
import 'package:health_and_hope/src/services/apis/data_source/remote/actividadApi.dart';
import 'package:health_and_hope/src/services/apis/repositories/actividadRepository.dart';

class ActividadRepositoryApiIm implements ActividadRepositoryApi {
  final ActividadesApi _api;
  ActividadRepositoryApiIm(this._api);

  @override
  Future<DataValues> misActividadesModif(String uidTarjetaModif) async {
    return await _api.misActividadesModif(uidTarjetaModif);
  }

  @override
  Future<DataValues> cambiarMiEstadoActividad({required String uuidEstado, required String uuidActividad}) {
    return _api.cambiarMiEstadoActividad(uuidActividad: uuidActividad, uuidEstado:uuidEstado );
  }



}