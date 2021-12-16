

import 'package:health_and_hope/src/models/baseModel/dataValues.dart';
import 'package:health_and_hope/src/repositories/refreshTokenAccess.dart';
import 'package:health_and_hope/src/services/apis/data_source/remote/departamentoApi.dart';
import 'package:health_and_hope/src/services/apis/data_source/remote/participanteApi.dart';
import 'package:health_and_hope/src/services/apis/data_source/remote/personalApi.dart';
import 'package:health_and_hope/src/services/apis/data_source/remote/personalDepartamentoApi.dart';
import 'package:health_and_hope/src/services/apis/http/http.dart';
import 'package:health_and_hope/src/services/apis/repositories/participanteRepository.dart';
import 'package:health_and_hope/src/services/apis/repositories/personalRepository.dart';
import 'package:health_and_hope/src/services/apis/repositories/departamentoRepository.dart';
import 'package:health_and_hope/src/services/apis/repositories/personalDepartamentoRepository.dart';
import 'package:health_and_hope/src/services/apis/repositories_impi/departamentoRepository.dart';
import 'package:health_and_hope/src/services/apis/repositories_impi/participanteRepository.dart';
import 'package:health_and_hope/src/services/apis/repositories_impi/personalDepartamentoRepository.dart';
import 'package:health_and_hope/src/services/apis/repositories_impi/personalRepository.dart';
import 'package:health_and_hope/src/services/service_pages/notificationService.dart';

class ParticipanteRepository {
  final ParticipanteRepositoryApi _participanteApi  = ParticipanteRepositoryApiIm(ParticipanteApi(Http()));
  final UserRefreshTokenRepository _refreshToken = UserRefreshTokenRepository();

  Future<DataValues> allParticipantes({required int page, required String email, required String dni}) async {
    DataValues values = await _participanteApi.allParticipantes(page: page, email: email, dni: dni);
    if (values.errorValue!=null) {
      final refreshTkn = await _refreshToken.refreshTokenUser(values.errorValue);
      if (refreshTkn.errorValue!=null) values.errorValue = refreshTkn.errorValue;
      else if (refreshTkn.modelValue != null) values = await _participanteApi.allParticipantes(page: page, email: email, dni: dni);
    }
    if (values.errorValue != null && (values.statusCode == 401 || values.statusCode == 403)) NotificationService.showMessageNoCredential(message: "${values.errorValue!['detail']} Status code: ${values.statusCode}", seconds: 5);
    return  values;
  }


  Future<DataValues> eliminarParticipante({required String idParticipante}) async {
    DataValues values = await _participanteApi.eliminarParticipante(idParticipante: idParticipante);
    if (values.errorValue!=null) {
      final refreshTkn = await _refreshToken.refreshTokenUser(values.errorValue);
      if (refreshTkn.errorValue!=null) values.errorValue = refreshTkn.errorValue;
      else if (refreshTkn.modelValue != null) values = await _participanteApi.eliminarParticipante(idParticipante: idParticipante);
    }
    if (values.errorValue != null && (values.statusCode == 401 || values.statusCode == 403)) NotificationService.showMessageNoCredential(message: "${values.errorValue!['detail']} Status code: ${values.statusCode}", seconds: 5);
    return  values;
  }


}