

import 'package:health_and_hope/src/models/baseModel/dataValues.dart';
import 'package:health_and_hope/src/repositories/refreshTokenAccess.dart';
import 'package:health_and_hope/src/services/apis/data_source/remote/departamentoApi.dart';
import 'package:health_and_hope/src/services/apis/data_source/remote/personalDepartamentoApi.dart';
import 'package:health_and_hope/src/services/apis/http/http.dart';
import 'package:health_and_hope/src/services/apis/repositories/departamentoRepository.dart';
import 'package:health_and_hope/src/services/apis/repositories/personalDepartamentoRepository.dart';
import 'package:health_and_hope/src/services/apis/repositories_impi/departamentoRepository.dart';
import 'package:health_and_hope/src/services/apis/repositories_impi/personalDepartamentoRepository.dart';
import 'package:health_and_hope/src/services/service_pages/notificationService.dart';

class PersonalDepartamentoRepository {
  final PersonalDepartamentoRepositoryApi _departamentoApi  = PersonalDepartamentoRepositoryApiIm(
      PersonalDepartamentoApi(Http())
  );
  final UserRefreshTokenRepository _refreshToken = UserRefreshTokenRepository();

  Future<DataValues> allPersonalDepartamento({required String uuidDepartamento, required int page}) async {
    DataValues values = await _departamentoApi.allPersonalDepartamento(
        uuidDepartamento: uuidDepartamento,
        page: page
    );
    if (values.errorValue!=null) {
      final refreshTkn = await _refreshToken.refreshTokenUser(values.errorValue);
      if (refreshTkn.errorValue!=null) values.errorValue = refreshTkn.errorValue;
      else {
        values = await _departamentoApi.allPersonalDepartamento(
            uuidDepartamento: uuidDepartamento,
            page: page
        );
        if (values.errorValue != null && (values.statusCode == 401 || values.statusCode == 403)) {
          NotificationService.showMessageNoCredential(message: "${values.errorValue!['detail']} Status code: ${values.statusCode}", seconds: 5);
        }
      }
    }
    return  values;
  }


  Future<DataValues> registrarPersonalDepartamento({required String uuidDepartamento, required String uuidPersonal}) async {
    DataValues? values = await _departamentoApi.registrarPersonalDepartamento(uuidDepartamento: uuidDepartamento,uuidPersonal: uuidPersonal);
    if (values.errorValue!=null) {
      final refreshTkn = await _refreshToken.refreshTokenUser(values.errorValue);
      if (refreshTkn.errorValue!=null) values.errorValue = refreshTkn.errorValue;
      else if (refreshTkn.modelValue != null) values = await _departamentoApi.registrarPersonalDepartamento(uuidDepartamento: uuidDepartamento,uuidPersonal: uuidPersonal);
    }

    if (values.errorValue != null && (values.statusCode == 401 || values.statusCode == 403)) NotificationService.showMessageNoCredential(message: "${values.errorValue!['detail']} Status code: ${values.statusCode}", seconds: 5);
    if (values.errorValue != null && values.errorValue!.containsKey('non_field_errors')) NotificationService.showMessageNoCredential(message: "El usuario ya esta registrado en este departamento", seconds: 5);
    if (values.statusCode! < 400) {
      NotificationService.showMessageSave(message: "Personal agregado correctamente", seconds: 5);

    }

    return  values;
  }


  Future<DataValues> eliminarPersonalDep({required String uuidPersonalDep}) async {
    DataValues? values = await _departamentoApi.eliminarPersonalDep(uuidPersonalDep: uuidPersonalDep);
    if (values.errorValue!=null) {
      final refreshTkn = await _refreshToken.refreshTokenUser(values.errorValue);
      if (refreshTkn.errorValue!=null) values.errorValue = refreshTkn.errorValue;
      else if (refreshTkn.modelValue != null) values = await _departamentoApi.eliminarPersonalDep(uuidPersonalDep: uuidPersonalDep);
    }
    if (values.errorValue != null && (values.statusCode == 401 || values.statusCode == 403)) NotificationService.showMessageNoCredential(message: "${values.errorValue!['detail']} Status code: ${values.statusCode}", seconds: 5);
    return  values;
  }



  Future<DataValues> allPersonalDepDisponible({required String idDepartamento}) async {
    DataValues? values = await _departamentoApi.allPersonalDepDisponible(idDepartamento: idDepartamento);
    if (values.errorValue!=null) {
      final refreshTkn = await _refreshToken.refreshTokenUser(values.errorValue);
      if (refreshTkn.errorValue!=null) values.errorValue = refreshTkn.errorValue;
      else if (refreshTkn.modelValue != null) values = await _departamentoApi.allPersonalDepDisponible(idDepartamento: idDepartamento);
    }
    if (values.errorValue != null && (values.statusCode == 401 || values.statusCode == 403)) NotificationService.showMessageNoCredential(message: "${values.errorValue!['detail']} Status code: ${values.statusCode}", seconds: 5);
    return values;
  }


  Future<DataValues> personalDisponibleParticipante({required String idParticipante, required String dni, required String email, required int page}) async {
    DataValues? values = await _departamentoApi.personalDisponibleParticipante(idParticipante: idParticipante, dni: dni, email: email, page: page);
    if (values.errorValue!=null) {
      final refreshTkn = await _refreshToken.refreshTokenUser(values.errorValue);
      if (refreshTkn.errorValue!=null) values.errorValue = refreshTkn.errorValue;
      else if (refreshTkn.modelValue != null) values = await _departamentoApi.personalDisponibleParticipante(idParticipante: idParticipante, dni: dni, email: email, page: page);
    }
    if (values.errorValue != null && (values.statusCode == 401 || values.statusCode == 403)) NotificationService.showMessageNoCredential(message: "${values.errorValue!['detail']} Status code: ${values.statusCode}", seconds: 5);
    return  values;
  }




}


