

import 'package:health_and_hope/src/form_controllers/departamentoFormController.dart';
import 'package:health_and_hope/src/models/baseModel/dataValues.dart';
import 'package:health_and_hope/src/repositories/refreshTokenAccess.dart';
import 'package:health_and_hope/src/services/apis/data_source/remote/asistenteApi.dart';
import 'package:health_and_hope/src/services/apis/data_source/remote/departamentoApi.dart';
import 'package:health_and_hope/src/services/apis/data_source/remote/protomotorApi.dart';
import 'package:health_and_hope/src/services/apis/http/http.dart';
import 'package:health_and_hope/src/services/apis/repositories/asistenteRepository.dart';
import 'package:health_and_hope/src/services/apis/repositories/departamentoRepository.dart';
import 'package:health_and_hope/src/services/apis/repositories/promotorRepository.dart';
import 'package:health_and_hope/src/services/apis/repositories_impi/asistenteRepository.dart';
import 'package:health_and_hope/src/services/apis/repositories_impi/departamentoRepository.dart';
import 'package:health_and_hope/src/services/apis/repositories_impi/promotorRepository.dart';
import 'package:health_and_hope/src/services/service_pages/notificationService.dart';

class PromotorRepository {

  final PromotorRepositoryApi _promotorApi  = PromotorRepositoryApiIm(PromotorApi(Http()));
  final UserRefreshTokenRepository _refreshToken = UserRefreshTokenRepository();

  Future<DataValues> promotoresParticipante({required String idParticipante}) async {
    DataValues? values = await _promotorApi.promotoresParticipante(idParticipante: idParticipante);
    if (values.errorValue!=null) {
      final refreshTkn = await _refreshToken.refreshTokenUser(values.errorValue);
      if (refreshTkn.errorValue!=null) values.errorValue = refreshTkn.errorValue;
      else if (refreshTkn.modelValue != null) values = await _promotorApi.promotoresParticipante(idParticipante: idParticipante);
    }
    if (values.errorValue != null && (values.statusCode == 401 || values.statusCode == 403)) NotificationService.showMessageNoCredential(message: "${values.errorValue!['detail']} Status code: ${values.statusCode}", seconds: 5);
    return  values;
  }

  Future<DataValues> registrarPromotorParticipante({required String idParticipante, required String idPromotorParticipante}) async {
    DataValues? values = await _promotorApi.registrarPromotorParticipante(idParticipante: idParticipante, idPromotorParticipante: idPromotorParticipante);
    if (values.errorValue!=null) {
      final refreshTkn = await _refreshToken.refreshTokenUser(values.errorValue);
      if (refreshTkn.errorValue!=null) values.errorValue = refreshTkn.errorValue;
      else if (refreshTkn.modelValue != null) values = await _promotorApi.registrarPromotorParticipante(idParticipante: idParticipante, idPromotorParticipante: idPromotorParticipante);
    }
    if (values.errorValue != null && (values.statusCode == 401 || values.statusCode == 403)) NotificationService.showMessageNoCredential(message: "${values.errorValue!['detail']} Status code: ${values.statusCode}", seconds: 5);
    values = await promotoresParticipante(idParticipante: idParticipante);
    return  values;
  }

  Future<DataValues> eliminarPromotorParticipante({required String idPromotorParticipante}) async {
    DataValues? values = await _promotorApi.eliminarPromotorParticipante(idPromotorParticipante: idPromotorParticipante);
    if (values.errorValue!=null) {
      final refreshTkn = await _refreshToken.refreshTokenUser(values.errorValue);
      if (refreshTkn.errorValue!=null) values.errorValue = refreshTkn.errorValue;
      else if (refreshTkn.modelValue != null) values = await _promotorApi.eliminarPromotorParticipante(idPromotorParticipante: idPromotorParticipante);
    }
    if (values.errorValue != null && (values.statusCode == 401 || values.statusCode == 403)) NotificationService.showMessageNoCredential(message: "${values.errorValue!['detail']} Status code: ${values.statusCode}", seconds: 5);
    return  values;
  }


}