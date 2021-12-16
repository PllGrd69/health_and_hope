import 'package:health_and_hope/src/models/baseModel/models.dart';
import 'package:health_and_hope/src/repositories/refreshTokenAccess.dart';
import 'package:health_and_hope/src/services/apis/data_source/remote/actividadApi.dart';
import 'package:health_and_hope/src/services/apis/http/http.dart';
import 'package:health_and_hope/src/services/apis/repositories/actividadRepository.dart';
import 'package:health_and_hope/src/services/apis/repositories_impi/actividadRepository.dart';
import 'package:health_and_hope/src/services/service_pages/notificationService.dart';

class ActividadRepository {
  final ActividadRepositoryApi _tarjetaModApi  = ActividadRepositoryApiIm(ActividadesApi(Http()));
  final UserRefreshTokenRepository _refreshToken = UserRefreshTokenRepository();


  Future<DataValues> misActividadesModif(String uidTarjetaModif) async {
    DataValues values = await _tarjetaModApi.misActividadesModif(uidTarjetaModif);
    if (values.errorValue!=null) {
      final refreshTkn = await _refreshToken.refreshTokenUser(values.errorValue);
      if (refreshTkn.errorValue!=null) values.errorValue = refreshTkn.errorValue;
      else {
        values = await _tarjetaModApi.misActividadesModif(uidTarjetaModif);
        if (values.errorValue != null && (values.statusCode == 401 || values.statusCode == 403)) {
          NotificationService.showMessageNoCredential(message: "${values.errorValue!['detail']} Status code: ${values.statusCode}", seconds: 5);
        }
      }
    }
    return  values;
  }

  Future<DataValues> cambiarMiEstadoActividad({required String uuidEstado, required String uuidActividad}) async {
    DataValues values = await _tarjetaModApi.cambiarMiEstadoActividad(uuidActividad: uuidActividad, uuidEstado: uuidEstado);
    if (values.errorValue!=null) {
      final refreshTkn = await _refreshToken.refreshTokenUser(values.errorValue);
      if (refreshTkn.errorValue!=null) values.errorValue = refreshTkn.errorValue;
      else {
        values = await _tarjetaModApi.cambiarMiEstadoActividad(uuidActividad: uuidActividad, uuidEstado: uuidEstado);
        if (values.errorValue != null && (values.statusCode == 401 || values.statusCode == 403)) {
          NotificationService.showMessageNoCredential(message: "${values.errorValue!['detail']} Status code: ${values.statusCode}", seconds: 5);
        }
      }
    }
    return values;
  }

}