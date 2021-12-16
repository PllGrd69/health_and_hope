
import 'package:health_and_hope/src/models/baseModel/models.dart';
import 'package:health_and_hope/src/services/apis/data_source/remote/userAppApi.dart';
import 'package:health_and_hope/src/services/apis/repositories/userAppRepository.dart';

class UserAppRepositoryApiIm implements UserAppRepositoryApi {
  final UserAppApi _api;

  UserAppRepositoryApiIm(this._api);
  Future<String?> get accessToken => throw UnimplementedError();

  @override
  Future<DataValues?> login(AccesUserModel accessUser) async {
   return await _api.login(accessUser);
  }

  @override
  Future<DataValues?> myUserApp() async {
    return await _api.myUserApp();
  }

  @override
  Future<DataValues> createUser(CreateUserModel createUserModel)async {
    return await _api.createUser(createUserModel);
  }

  @override
  Future<DataValues?> refreshTokenUser(String refreshToken)async {
    return await _api.refreshTokenUser(refreshToken);
  }

  @override
  Future<DataValues?> updateMyUserApp(UserModel userUpdate) async {
    return await _api.updateMyUserApp(userUpdate);
  }

  @override
  Future<DataValues?> updateMyImageUserApp(String imageBase64) async {
    return await _api.updateMyImageUserApp(imageBase64);
  }

  @override
  Future<DataValues> sendEmailResetPwd(String email)  async {
    return await _api.sendEmailResetPwd(email);
  }

  @override
  Future<DataValues> resetPassword({required String password, required String token}) async {
    return await _api.resetPassword(password: password, token: token);
  }

}