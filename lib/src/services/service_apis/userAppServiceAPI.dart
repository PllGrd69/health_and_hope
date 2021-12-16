import 'dart:convert';

import 'package:health_and_hope/src/models/baseModel/models.dart';
import 'package:health_and_hope/src/services/service_apis/conection.dart';
import 'package:http/http.dart' as http;


class UserAppServiceApi {

  Future<DataValues> createUser(CreateUserModel createUserModel) async {
    final url = Uri.https(ApiConnection.getUrlApi(), 'api/auth/register/');
    final res = await http.post(
        url,
        headers: await ApiConnection.getHeaderApiKey(),
        body: createUserModel.toJson()
    );
    DataValues dataValues;
    if(res.statusCode==200 || res.statusCode==201) {
      dataValues = DataValues(
        modelValue: UserModel.fromJson(res.body),
      );
    } else {
      dataValues = DataValues(
        errorValue: json.decode(utf8.decode(res.bodyBytes))
      );
    }
    dataValues.statusCode = res.statusCode;
    return dataValues;
  }

  Future<DataValues> accessUserApp(AccesUserModel accessUserModel) async {
    final url = Uri.https(ApiConnection.getUrlApi(), 'api/auth/login/');
    final res = await http.post(
        url,
        headers: await ApiConnection.getHeaderApiKeyTokenUser(),
        body: accessUserModel.toJson()
    );
    DataValues dataValues;
    if(res.statusCode==200 || res.statusCode==201) {
      dataValues = DataValues(
        modelValue: AccessUserTokenModel.fromJson(res.bodyBytes),
      );
    } else {
      dataValues = DataValues(
          errorValue: json.decode(utf8.decode(res.bodyBytes))
      );
    }
    dataValues.statusCode = res.statusCode;
    return dataValues;
  }

  Future<DataValues> myUserApp() async {
    print(await ApiConnection.getHeaderApiKeyTokenUser());
    final url = Uri.https(ApiConnection.getUrlApi(), 'api/auth/me/');
    final res = await http.get(
        url,
        headers: await ApiConnection.getHeaderApiKeyTokenUser(),
    );
    DataValues dataValues;
    if(res.statusCode==200 || res.statusCode==201) {
      dataValues = DataValues(
        modelValue: UserModel.fromJson(res.body),
      );
    } else {
      dataValues = DataValues(
          errorValue: json.decode(utf8.decode(res.bodyBytes))
      );
    }
    dataValues.statusCode = res.statusCode;
    return dataValues;
  }

}