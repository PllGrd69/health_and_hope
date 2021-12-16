import 'package:health_and_hope/src/models/baseModel/models.dart';

abstract class ProgresoActividadRepositoryApi {
  Future<DataValues> miProgresoActividades();
  Future<DataValues> miProgresoSemanal({required String uuidTarjeta});
  Future<DataValues> misTarjetasProgresoActividad();
}