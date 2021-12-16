import 'package:health_and_hope/src/models/baseModel/models.dart';
import 'package:health_and_hope/src/services/apis/data_source/remote/userAppApi.dart';
import 'package:health_and_hope/src/services/apis/http/http.dart';
import 'package:health_and_hope/src/services/apis/repositories/userAppRepository.dart';
import 'package:health_and_hope/src/services/apis/repositories_impi/userAppRepository.dart';
import 'package:health_and_hope/src/services/service_pages/notificationService.dart';
import 'package:health_and_hope/src/share_prefs/preferencias_usuario.dart';

class UserRefreshTokenRepository {

  final UserAppRepositoryApi _userApi = UserAppRepositoryApiIm(UserAppApi(Http()));

  static final UserRefreshTokenRepository _instancia = UserRefreshTokenRepository._();
  UserRefreshTokenRepository._(){
    print("Iniciado UserRefreshTokenRepository");
  }

  factory UserRefreshTokenRepository(){
    return _instancia;
  }

  Future<DataValues> refreshTokenUser(Map<dynamic, dynamic>? errorValue, {bool mostrarError = false}) async {
    DataValues? values;
    final prefUsuario = PreferencesUserApp();
    if (
    errorValue != null &&
        errorValue.containsKey('code') &&
        errorValue['code'] == 'token_not_valid'
    ) {
      final refreshToken = await prefUsuario.getRefreshToken();
      if (refreshToken.isNotEmpty) {
        values = await  _userApi.refreshTokenUser(refreshToken);
        if (values!.modelValue!=null){
          print((values.modelValue as AccessUserTokenModel).access);
          final tokenAccessUser = (values.modelValue as AccessUserTokenModel);
          await prefUsuario.setAccessToken(tokenAccessUser.access);
        } else {
          if (values.errorValue!=null && (values.statusCode == 401 || values.statusCode == 403) && mostrarError) {
            NotificationService.showMessageNoCredential(
                message: "${values.errorValue!['detail']} Status code: ${values.statusCode}",
                seconds: 5
            );
          }
          await prefUsuario.setAccessToken('');
          await prefUsuario.setRefreshToken('');
        }
      }
    }
    return values?? DataValues();
  }

}