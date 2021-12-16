
import 'package:health_and_hope/src/form_controllers/login_screen_controller.dart';
import 'package:health_and_hope/src/form_controllers/register_screen_controller.dart';
import 'package:health_and_hope/src/form_controllers/sendEmailResetController.dart';
import 'package:health_and_hope/src/models/baseModel/models.dart';
import 'package:health_and_hope/src/models/models/userModel.dart';
import 'package:health_and_hope/src/repositories/refreshTokenAccess.dart';
import 'package:health_and_hope/src/services/apis/data_source/remote/userAppApi.dart';
import 'package:health_and_hope/src/services/apis/http/http.dart';
import 'package:health_and_hope/src/services/apis/repositories/userAppRepository.dart';
import 'package:health_and_hope/src/services/apis/repositories_impi/userAppRepository.dart';
import 'package:health_and_hope/src/services/service_apis/userAppServiceAPI.dart';
import 'package:health_and_hope/src/services/service_pages/notificationService.dart';
import 'package:health_and_hope/src/share_prefs/preferencias_usuario.dart';

class UserAppRepository {

  final UserAppRepositoryApi _userAppApi  = UserAppRepositoryApiIm(UserAppApi(Http()));
  late UserAppServiceApi userAppServiceApi;

  UserAppRepository(){
    userAppServiceApi = UserAppServiceApi();
  }

  Future<DataValues> accessUserApp(AccesUserModel accessUserModel) async {
    final values = await  _userAppApi.login(accessUserModel);
    if (values!.errorValue != null && (values.statusCode == 401 || values.statusCode == 403)) {
      NotificationService.showMessageNoCredential(message: values.errorValue!['detail'], seconds: 5);
    }
    if (values.modelValue!=null){
      // NotificationService.showMessageSave(message: 'Bienvenido ..name_user..', seconds: 5);
      final tokenAccessUser = (values.modelValue as AccessUserTokenModel);
      await PreferencesUserApp().setAccessToken(tokenAccessUser.access);
      await PreferencesUserApp().setRefreshToken(tokenAccessUser.refresh);
    }
    loginController.errorFormsMapFromApi(values.errorValue);
    return values;
  }

  Future<DataValues> myUserApp() async {
    final values = await _userAppApi.myUserApp();
    if (values!.errorValue != null && (values.statusCode == 401 || values.statusCode == 403)) {
      NotificationService.showMessageNoCredential(message: values.errorValue!['detail'], seconds: 5);
    }
    if (values.modelValue!=null){
      NotificationService.showMessageSave(message: 'Bienvenido ${(values.modelValue as UserModel).username}', seconds: 1);
    }
    return values;
  }

  Future<DataValues> updateMyUserApp(UserModel userUpdate) async {
    final values = await _userAppApi.updateMyUserApp(userUpdate);
    if (values!.errorValue != null && (values.statusCode == 401 || values.statusCode == 403)) {
      await NotificationService.showMessageNoCredential(message: "${values.errorValue!['detail']} Status code: ${values.statusCode}", seconds: 2);
    }
    if (values.modelValue!=null){
      await NotificationService.showMessageSave(message: 'Datos actualizados', seconds: 2);
    }
    return values;
  }


  Future<DataValues> updateMyImageUserApp(String imageBase64) async {
    final values = await _userAppApi.updateMyImageUserApp(imageBase64);
    if (values!.modelValue != null){
      await NotificationService.showMessageSave(message: 'Imagen actualizada', seconds: 2);
    }
    return values;
  }


  Future<DataValues> sendEmailResetPwd(String email) async {
    final values = await _userAppApi.sendEmailResetPwd(email);
    if (values.statusCode==200){
      NotificationService.showMessageSave(message: 'Se envio un token a su correo $email', seconds: 3);
    } else {
      sendEmailResetPwdController.errorFormsMapFromApi(values.errorValue);
    }
    return values;
  }


  Future<DataValues> resetPassword({required String token, required String password}) async {
    final values = await _userAppApi.resetPassword(password: password, token: token);
    if (values.statusCode==200){
      NotificationService.showMessageSave(message: 'Contraseña cambiada', seconds: 3);
    } else if (values.statusCode==404) {
      NotificationService.showMessageDizzy(message: 'El token es incorrecto', seconds: 3);
    }
    else {
      sendEmailResetPwdController.errorFormsMapFromApi(values.errorValue);
    }
    return values;
  }
}