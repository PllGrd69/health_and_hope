import 'package:health_and_hope/src/models/baseModel/models.dart';
import 'package:health_and_hope/src/repositories/refreshTokenAccess.dart';
import 'package:health_and_hope/src/services/apis/data_source/remote/actividadAyudaApi.dart';
import 'package:health_and_hope/src/services/apis/http/http.dart';
import 'package:health_and_hope/src/services/apis/repositories/actividadAyudaRepository.dart';
import 'package:health_and_hope/src/services/apis/repositories_impi/actividadAyudaRepository.dart';
import 'package:health_and_hope/src/services/service_pages/notificationService.dart';

class ActividadAyudaRepository {
  final ActividadAyudaRepositoryApi _tarjetaModApi  = ActividadAyudaRepositoryApiIm(ActividadAyudaApi(Http()));
  final UserRefreshTokenRepository _refreshToken = UserRefreshTokenRepository();

  Future<DataValues> misActividadesAyuda({required String uuidActividad}) async {
    DataValues values = await _tarjetaModApi.misActividadesAyuda(uuidActividad: uuidActividad);
    if (values.errorValue!=null) {
      final refreshTkn = await _refreshToken.refreshTokenUser(values.errorValue);
      if (refreshTkn.errorValue!=null) values.errorValue = refreshTkn.errorValue;
      else {
        values = await _tarjetaModApi.misActividadesAyuda(uuidActividad: uuidActividad);
        if (values.errorValue != null && (values.statusCode == 401 || values.statusCode == 403)) {
          NotificationService.showMessageNoCredential(message: "${values.errorValue!['detail']} Status code: ${values.statusCode}", seconds: 5);
        }
      }
    }
    return  values;
  }


}