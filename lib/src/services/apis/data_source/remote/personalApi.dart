
import 'package:health_and_hope/src/models/baseModel/models.dart';
import 'package:health_and_hope/src/models/models/actividadAyudaModel.dart';
import 'package:health_and_hope/src/services/apis/data_source/credentialsApi.dart';
import 'package:health_and_hope/src/services/apis/http/http.dart';
import 'package:health_and_hope/src/services/apis/http/httpMethod.dart';
import 'package:health_and_hope/src/share_prefs/preferencias_usuario.dart';

class PersonalApi {
  final Http _http;
  PersonalApi(this._http);

  Future<DataValues> allPersonal() async {

    print("All personal");
    final result = await _http.request<List<PersonalModel>>(
      '/api/personal/',
      method: HttpMethod.get,
      headers: {
        'X-Api-Key': CredentialsApi.apiKey,
        "Authorization": "Bearer ${await PreferencesUserApp().getAccessToken()}",
      },
      parser: (data) => (data as List).map((e) => PersonalModel.fromMap(e)).toList()
    );
    return DataValues (
        modelValueList: result.data,
        errorValue: (result.error!=null)?result.error!.data: null,
        statusCode: result.statusCode
    );
  }

  Future<DataValues> listaPersonal({required String dni, required String email, required int page}) async {
    final result = await _http.request<PersonalModelPagModel>(
        '/api/personalPag/',
        method: HttpMethod.get,
        queryParameters: {
          'page': page.toString(),
          'personal__email': email,
          'personal__dni': dni
        },
        headers: {
          'X-Api-Key': CredentialsApi.apiKey,
          "Authorization": "Bearer ${await PreferencesUserApp().getAccessToken()}",
        },
        parser: (data) =>PersonalModelPagModel.fromMap(data)
    );
    return DataValues (
        modelValue: result.data,
        errorValue: (result.error!=null)?result.error!.data: null,
        statusCode: result.statusCode
    );
  }

  Future<DataValues> eliminarPersonal({required String idPersonal}) async {
    final result = await _http.request(
      '/api/personal/$idPersonal/',
      method: HttpMethod.get,
      headers: {
        'X-Api-Key': CredentialsApi.apiKey,
        "Authorization": "Bearer ${await PreferencesUserApp().getAccessToken()}",
      },
    );
    return DataValues (
        errorValue: (result.error!=null)?result.error!.data: null,
        statusCode: result.statusCode
    );
  }


}