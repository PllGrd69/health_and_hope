
import 'package:health_and_hope/src/models/baseModel/models.dart';

abstract class ActividadRepositoryApi {
  Future<DataValues> misActividadesModif(String uidTarjetaModif);
  Future<DataValues> cambiarMiEstadoActividad({required String uuidEstado, required String uuidActividad});

}