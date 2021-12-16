import 'package:health_and_hope/src/models/baseModel/models.dart';
import 'package:health_and_hope/src/repositories/refreshTokenAccess.dart';
import 'package:health_and_hope/src/services/apis/data_source/remote/actividadApi.dart';
import 'package:health_and_hope/src/services/apis/data_source/remote/actividadAyudaApi.dart';
import 'package:health_and_hope/src/services/apis/data_source/remote/progresoActividadApi.dart';
import 'package:health_and_hope/src/services/apis/http/http.dart';
import 'package:health_and_hope/src/services/apis/repositories/actividadAyudaRepository.dart';
import 'package:health_and_hope/src/services/apis/repositories/progresoActividadRepository.dart';
import 'package:health_and_hope/src/services/apis/repositories_impi/actividadAyudaRepository.dart';
import 'package:health_and_hope/src/services/apis/repositories_impi/progresoActividadRepository.dart';
import 'package:health_and_hope/src/services/service_pages/notificationService.dart';

class ProgresoActividadRepository {

  final ProgresoActividadRepositoryApi _progresActiApi  = ProgresoActividadRepositoryApiIm(ProgresoActividadApi(Http()));
  final UserRefreshTokenRepository _refreshToken = UserRefreshTokenRepository();

  Future<DataValues> miProgresoActividad() async {
    DataValues values = await _progresActiApi.miProgresoActividades();
    if (values.errorValue!=null) {
      final refreshTkn = await _refreshToken.refreshTokenUser(values.errorValue);
      if (refreshTkn.errorValue!=null) values.errorValue = refreshTkn.errorValue;
      else {
        values = await _progresActiApi.miProgresoActividades();
        if (values.errorValue != null && (values.statusCode == 401 || values.statusCode == 403)) {
          NotificationService.showMessageNoCredential(message: "${values.errorValue!['detail']} Status code: ${values.statusCode}", seconds: 5);
        }
      }
    }

    return  values;
  }

  Future<DataValues> misTarjetasProgresoActividad() async {
    DataValues values = await _progresActiApi.misTarjetasProgresoActividad();
    if (values.errorValue!=null) {
      final refreshTkn = await _refreshToken.refreshTokenUser(values.errorValue);
      if (refreshTkn.errorValue!=null) values.errorValue = refreshTkn.errorValue;
      else {
        values = await _progresActiApi.misTarjetasProgresoActividad();
        if (values.errorValue != null && (values.statusCode == 401 || values.statusCode == 403)) {
          NotificationService.showMessageNoCredential(message: "${values.errorValue!['detail']} Status code: ${values.statusCode}", seconds: 5);
        }
      }
    }
    return  values;
  }

}