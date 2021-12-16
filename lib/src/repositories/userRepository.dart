
import 'package:health_and_hope/src/form_controllers/login_screen_controller.dart';
import 'package:health_and_hope/src/form_controllers/register_screen_controller.dart';
import 'package:health_and_hope/src/form_controllers/sendEmailResetController.dart';
import 'package:health_and_hope/src/models/baseModel/models.dart';
import 'package:health_and_hope/src/models/models/userModel.dart';
import 'package:health_and_hope/src/repositories/refreshTokenAccess.dart';
import 'package:health_and_hope/src/services/apis/data_source/remote/userApi.dart';
import 'package:health_and_hope/src/services/apis/http/http.dart';
import 'package:health_and_hope/src/services/apis/repositories/userRepository.dart';
import 'package:health_and_hope/src/services/apis/repositories_impi/userRepository.dart';
import 'package:health_and_hope/src/services/service_apis/userAppServiceAPI.dart';
import 'package:health_and_hope/src/services/service_pages/notificationService.dart';
import 'package:health_and_hope/src/share_prefs/preferencias_usuario.dart';

class UserRepository {

  final UserRepositoryApi _userApi  = UserRepositoryApiIm(UserApi(Http()));
  final UserRefreshTokenRepository _refreshToken = UserRefreshTokenRepository();

  Future<DataValues> crearUsuario(CreateUserModel userModel) async {
    DataValues? values = await _userApi.crearUsuario(userModel);
    if (values.errorValue!=null) {
      final refreshTkn = await _refreshToken.refreshTokenUser(values.errorValue);
      if (refreshTkn.errorValue!=null) values.errorValue = refreshTkn.errorValue;
      else if (refreshTkn.modelValue != null) values = await _userApi.crearUsuario(userModel);
    }
    if (values.errorValue != null && (values.statusCode == 401 || values.statusCode == 403)) NotificationService.showMessageNoCredential(message: "${values.errorValue!['detail']} Status code: ${values.statusCode}", seconds: 5);
    if (values.modelValue!=null) NotificationService.showMessageSave(message: 'Usuario registrado correctamente', seconds: 3);
    registerUserController.errorFormsMapFromApi(values.errorValue);
    return  values;
  }

}