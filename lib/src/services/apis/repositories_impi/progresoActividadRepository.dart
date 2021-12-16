
import 'package:health_and_hope/src/models/baseModel/dataValues.dart';
import 'package:health_and_hope/src/services/apis/data_source/remote/actividadAyudaApi.dart';
import 'package:health_and_hope/src/services/apis/data_source/remote/progresoActividadApi.dart';
import 'package:health_and_hope/src/services/apis/repositories/actividadAyudaRepository.dart';
import 'package:health_and_hope/src/services/apis/repositories/progresoActividadRepository.dart';

class ProgresoActividadRepositoryApiIm implements ProgresoActividadRepositoryApi {
  final ProgresoActividadApi _api;
  ProgresoActividadRepositoryApiIm(this._api);

  @override
  Future<DataValues> miProgresoActividades() async {
    return await this._api.miProgresoActividad();
  }

  @override
  Future<DataValues> miProgresoSemanal({required String uuidTarjeta}) async  {
    return await this._api.miProgresoSemanal(uuidTarjeta: uuidTarjeta);
  }

  @override
  Future<DataValues> misTarjetasProgresoActividad() async {

    return await this._api.misTarjetasProgresoActividad();
  }


}