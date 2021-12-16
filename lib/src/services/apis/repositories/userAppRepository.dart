
import 'package:health_and_hope/src/models/baseModel/models.dart';

abstract class UserAppRepositoryApi {
  Future<DataValues?> login(AccesUserModel accessUser);
  Future<DataValues?> myUserApp();
  Future<DataValues> createUser(CreateUserModel createUserModel);
  Future<DataValues?> refreshTokenUser(String refreshToken);
  Future<DataValues?> updateMyUserApp(UserModel userUpdate);
  Future<DataValues?> updateMyImageUserApp(String imageBase64);
  Future<DataValues> sendEmailResetPwd(String email);
  Future<DataValues> resetPassword({required String password, required String token});
}