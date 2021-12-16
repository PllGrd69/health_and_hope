import 'dart:async';

import 'package:health_and_hope/src/models/baseModel/models.dart';
import 'package:health_and_hope/src/services/apis/data_source/credentialsApi.dart';
import 'package:health_and_hope/src/services/apis/http/http.dart';
import 'package:health_and_hope/src/services/apis/http/httpMethod.dart';
import 'package:health_and_hope/src/share_prefs/preferencias_usuario.dart';

class UserAppApi {
  final Http _http;
  UserAppApi(this._http);

  Future<DataValues> login(AccesUserModel accessUser) async {
    final result = await _http.request<AccessUserTokenModel>(
      '/api/auth/login/',
      method: HttpMethod.post,
      body: accessUser.toMap(),
      parser: (data) {
        final val = AccessUserTokenModel.fromMap(data);
        return val;
      }
    );
    return DataValues (modelValue: result.data,errorValue: (result.error!=null)?result.error!.data: null, statusCode: result.statusCode);
  }

  Future<DataValues> myUserApp() async {
    final result = await _http.request<UserModel>(
        '/api/auth/me/',
        method: HttpMethod.get,
        headers: {
          'X-Api-Key': CredentialsApi.apiKey,
          "Authorization": "Bearer ${await PreferencesUserApp().getAccessToken()}",
        },
        parser: (data) => UserModel.fromMap(data)
    );
    return DataValues ( modelValue: result.data, errorValue: (result.error!=null)?result.error!.data: null, statusCode: result.statusCode);
  }

  Future<DataValues> createUser(CreateUserModel createUserModel) async {
    final result = await _http.request<UserModel>(
        '/api/auth/register/',
        method: HttpMethod.post,
        headers: {
          'X-Api-Key': CredentialsApi.apiKey,
        },
        body: createUserModel.toMap(),
        parser: (data) => UserModel.fromMap(data)
    );
    final errorValue = (result.error!=null)?result.error!.data: null;
    return DataValues ( modelValue: result.data, errorValue: errorValue, statusCode: result.statusCode);
  }

  Future<DataValues> refreshTokenUser(String refreshToken) async {
    final result = await _http.request<AccessUserTokenModel>(
        '/api/auth/token/refresh/',
        method: HttpMethod.post,
        body: {
          'refresh': refreshToken
        },
        parser: (data) => AccessUserTokenModel.fromMap(data)
    );
    final errorValue = (result.error!=null)?result.error!.data: null;
    return DataValues ( modelValue: result.data, errorValue: errorValue, statusCode: result.statusCode);
  }

  Future<DataValues> updateMyUserApp(UserModel userUpdate) async {
    final result = await _http.request<UserModel>(
        '/api/auth/me/',
        method: HttpMethod.put,
        headers: {
          'X-Api-Key': CredentialsApi.apiKey,
          "Authorization": "Bearer ${await PreferencesUserApp().getAccessToken()}",
        },
        body: userUpdate.toMap(),
        parser: (data) => UserModel.fromMap(data)
    );
    final errorValue = (result.error!=null)?result.error!.data: null;
    return DataValues ( modelValue: result.data, errorValue: errorValue, statusCode: result.statusCode);
  }

  Future<DataValues> updateMyImageUserApp(String imageBase64) async {
    final result = await _http.request<UserModel>(
        '/api/auth/me/image',
        method: HttpMethod.put,
        headers: {
          'X-Api-Key': CredentialsApi.apiKey,
          "Authorization": "Bearer ${await PreferencesUserApp().getAccessToken()}",
        },
        body: {
          'avatar': imageBase64
        },
        parser: (data) => UserModel.fromMap(data)
    );
    final errorValue = (result.error!=null)?result.error!.data: null;
    return DataValues ( modelValue: result.data, errorValue: errorValue, statusCode: result.statusCode);
  }

  Future<DataValues> sendEmailResetPwd(String email) async{
    final result = await _http.request<UserModel>(
        '/api/auth/password_reset/',
        method: HttpMethod.post,
        body: {'email': email},
    );
    final errorValue = (result.error!=null)?result.error!.data: null;
    return DataValues ( modelValue: result.data, errorValue: errorValue, statusCode: result.statusCode);
  }

  Future<DataValues> resetPassword({required String password, required String token}) async {
    final result = await _http.request<UserModel>(
      '/api/auth/password_reset/confirm/',
      method: HttpMethod.post,
      body: {
        "password": password,
        "token": token
      }
    );
    final errorValue = (result.error!=null)?result.error!.data: null;
    return DataValues ( modelValue: result.data, errorValue: errorValue, statusCode: result.statusCode);
  }

}