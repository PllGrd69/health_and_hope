import 'dart:async';

import 'package:health_and_hope/src/models/baseModel/models.dart';
import 'package:health_and_hope/src/services/apis/data_source/credentialsApi.dart';
import 'package:health_and_hope/src/services/apis/http/http.dart';
import 'package:health_and_hope/src/services/apis/http/httpMethod.dart';
import 'package:health_and_hope/src/share_prefs/preferencias_usuario.dart';

class UserApi {
  final Http _http;
  UserApi(this._http);

  Future<DataValues> crearUsuario(CreateUserModel createUserModel) async {
    final result = await _http.request<UserModel>(
        '/api/auth/register/',
        method: HttpMethod.post,
        headers: {
          'X-Api-Key': CredentialsApi.apiKey,
          "Authorization": "Bearer ${await PreferencesUserApp().getAccessToken()}",
        },
        body: createUserModel.toMap(),
        parser: (data) => UserModel.fromMap(data)
    );
    final errorValue = (result.error!=null)?result.error!.data: null;
    return DataValues ( modelValue: result.data, errorValue: errorValue, statusCode: result.statusCode);
  }

}