

import 'package:health_and_hope/src/form_controllers/departamentoFormController.dart';
import 'package:health_and_hope/src/models/baseModel/dataValues.dart';
import 'package:health_and_hope/src/repositories/refreshTokenAccess.dart';
import 'package:health_and_hope/src/services/apis/data_source/remote/departamentoApi.dart';
import 'package:health_and_hope/src/services/apis/http/http.dart';
import 'package:health_and_hope/src/services/apis/repositories/departamentoRepository.dart';
import 'package:health_and_hope/src/services/apis/repositories_impi/departamentoRepository.dart';
import 'package:health_and_hope/src/services/service_pages/notificationService.dart';

class DepartamentoRepository {
  final DepartamentoRepositoryApi _departamentoApi  = DepartamentoRepositoryApiIm(DepartamentoApi(Http()));
  final UserRefreshTokenRepository _refreshToken = UserRefreshTokenRepository();

  Future<DataValues> allDepartamentos() async {
    DataValues values = await _departamentoApi.allDepartamentos();
    if (values.errorValue!=null) {
      final refreshTkn = await _refreshToken.refreshTokenUser(values.errorValue);
      if (refreshTkn.errorValue!=null) values.errorValue = refreshTkn.errorValue;
      else {
        values = await _departamentoApi.allDepartamentos();
      }
    }
    if (values.errorValue != null && (values.statusCode == 401 || values.statusCode == 403)) {
      NotificationService.showMessageNoCredential(message: "${values.errorValue!['detail']} Status code: ${values.statusCode}", seconds: 5);
    }
    return  values;
  }

  Future<DataValues> crearDepartamento({required String nombre}) async {
    DataValues values = await _departamentoApi.crearDepartamento(nombre: nombre);
    if (values.errorValue!=null) {
      final refreshTkn = await _refreshToken.refreshTokenUser(values.errorValue);
      if (refreshTkn.errorValue!=null) values.errorValue = refreshTkn.errorValue;
      else {
        values = await _departamentoApi.crearDepartamento(nombre: nombre);
      }
    }
    if (values.errorValue != null && (values.statusCode == 401 || values.statusCode == 403)) {
      NotificationService.showMessageNoCredential(message: "${values.errorValue!['detail']} Status code: ${values.statusCode}", seconds: 5);
    }
    departamentoFormController.errorFormsMapFromApi(values.errorValue);
    return  values;
  }

}