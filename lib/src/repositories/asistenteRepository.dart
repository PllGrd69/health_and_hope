

import 'package:health_and_hope/src/form_controllers/departamentoFormController.dart';
import 'package:health_and_hope/src/models/baseModel/dataValues.dart';
import 'package:health_and_hope/src/repositories/refreshTokenAccess.dart';
import 'package:health_and_hope/src/services/apis/data_source/remote/asistenteApi.dart';
import 'package:health_and_hope/src/services/apis/data_source/remote/departamentoApi.dart';
import 'package:health_and_hope/src/services/apis/http/http.dart';
import 'package:health_and_hope/src/services/apis/repositories/asistenteRepository.dart';
import 'package:health_and_hope/src/services/apis/repositories/departamentoRepository.dart';
import 'package:health_and_hope/src/services/apis/repositories_impi/asistenteRepository.dart';
import 'package:health_and_hope/src/services/apis/repositories_impi/departamentoRepository.dart';
import 'package:health_and_hope/src/services/service_pages/notificationService.dart';

class AsistenteRepository {
  final AsistenteRepositoryApi _asistenteApi  = AsistenteRepositoryApiIm(AsistenteApi(Http()));
  final UserRefreshTokenRepository _refreshToken = UserRefreshTokenRepository();

  Future<DataValues> asistentesParticipante({required String idParticipante}) async {
    DataValues? values = await _asistenteApi.asistentesParticipante(idParticipante: idParticipante);
    if (values.errorValue!=null) {
      final refreshTkn = await _refreshToken.refreshTokenUser(values.errorValue);
      if (refreshTkn.errorValue!=null) values.errorValue = refreshTkn.errorValue;
      else if (refreshTkn.modelValue != null) values = await _asistenteApi.asistentesParticipante(idParticipante: idParticipante);
    }
    if (values.errorValue != null && (values.statusCode == 401 || values.statusCode == 403)) NotificationService.showMessageNoCredential(message: "${values.errorValue!['detail']} Status code: ${values.statusCode}", seconds: 5);
    return  values;
  }

  Future<DataValues> asistentesDisponiblesParticipante({required String idParticipante, required String email, required String dni, required int page}) async {
    DataValues? values = await _asistenteApi.asistentesDisponiblesParticipante(idParticipante: idParticipante, email: email, dni: dni ,page: page);
    if (values.errorValue!=null) {
      final refreshTkn = await _refreshToken.refreshTokenUser(values.errorValue);
      if (refreshTkn.errorValue!=null) values.errorValue = refreshTkn.errorValue;
      else if (refreshTkn.modelValue != null) values = await _asistenteApi.asistentesDisponiblesParticipante(idParticipante: idParticipante, email: email, dni: dni, page: page);
    }
    if (values.errorValue != null && (values.statusCode == 401 || values.statusCode == 403)) NotificationService.showMessageNoCredential(message: "${values.errorValue!['detail']} Status code: ${values.statusCode}", seconds: 5);
    return  values;
  }

  Future<DataValues> registrarAsistenteParticipante({required String idParticipante, required String idAsistente}) async {
    DataValues values = await _asistenteApi.registrarAsistenteParticipante(idParticipante: idParticipante, idAsistente: idAsistente);
    if (values.errorValue!=null) {
      final refreshTkn = await _refreshToken.refreshTokenUser(values.errorValue);
      if (refreshTkn.errorValue!=null) values.errorValue = refreshTkn.errorValue;
      else if (refreshTkn.modelValue != null) values = await _asistenteApi.registrarAsistenteParticipante(idParticipante: idParticipante, idAsistente: idAsistente);
    }
    values = await asistentesParticipante(idParticipante: idParticipante);
    if (values.errorValue != null && (values.statusCode == 401 || values.statusCode == 403)) NotificationService.showMessageNoCredential(message: "${values.errorValue!['detail']} Status code: ${values.statusCode}", seconds: 5);
    return  values;
  }

  Future<DataValues> eliminarAsistenteParticipante({required String idParticipante, required String idAsistente}) async {
    DataValues values = await _asistenteApi.eliminarAsistenteParticipante(idParticipante: idParticipante, idAsistente: idAsistente);
    if (values.errorValue!=null) {
      final refreshTkn = await _refreshToken.refreshTokenUser(values.errorValue);
      if (refreshTkn.errorValue!=null) values.errorValue = refreshTkn.errorValue;
      else if (refreshTkn.modelValue != null) values = await _asistenteApi.eliminarAsistenteParticipante(idParticipante: idParticipante, idAsistente: idAsistente);
    }
    if (values.errorValue != null && (values.statusCode == 401 || values.statusCode == 403)) NotificationService.showMessageNoCredential(message: "${values.errorValue!['detail']} Status code: ${values.statusCode}", seconds: 5);
    return  values;
  }

  Future<DataValues> todosAsistentes({required String email, required String dni, required int page}) async {
    DataValues values = await _asistenteApi.todosAsistentes(email: email, dni: dni, page: page);
    if (values.errorValue!=null) {
      final refreshTkn = await _refreshToken.refreshTokenUser(values.errorValue);
      if (refreshTkn.errorValue!=null) values.errorValue = refreshTkn.errorValue;
      else if (refreshTkn.modelValue != null) values = await _asistenteApi.todosAsistentes(email: email, dni: dni, page: page);
    }
    if (values.errorValue != null && (values.statusCode == 401 || values.statusCode == 403)) NotificationService.showMessageNoCredential(message: "${values.errorValue!['detail']} Status code: ${values.statusCode}", seconds: 5);
    return values;
  }

  Future<DataValues> eliminarAsistente({required String idAsistente}) async {
    DataValues values = await _asistenteApi.eliminarAsistente(idAsistente: idAsistente);
    if (values.errorValue!=null) {
      final refreshTkn = await _refreshToken.refreshTokenUser(values.errorValue);
      if (refreshTkn.errorValue!=null) values.errorValue = refreshTkn.errorValue;
      else if (refreshTkn.modelValue != null) values = await _asistenteApi.eliminarAsistente(idAsistente: idAsistente);
    }
    if (values.errorValue != null && (values.statusCode == 401 || values.statusCode == 403)) NotificationService.showMessageNoCredential(message: "${values.errorValue!['detail']} Status code: ${values.statusCode}", seconds: 5);
    return values;
  }

}