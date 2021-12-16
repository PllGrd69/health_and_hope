import 'package:health_and_hope/src/models/baseModel/models.dart';

abstract class ActividadAyudaRepositoryApi {
  Future<DataValues> misActividadesAyuda({required String uuidActividad});
}