
import 'package:health_and_hope/src/models/baseModel/models.dart';
import 'package:health_and_hope/src/models/models/actividadAyudaModel.dart';
import 'package:health_and_hope/src/services/apis/data_source/credentialsApi.dart';
import 'package:health_and_hope/src/services/apis/http/http.dart';
import 'package:health_and_hope/src/services/apis/http/httpMethod.dart';
import 'package:health_and_hope/src/share_prefs/preferencias_usuario.dart';

class DepartamentoApi {
  final Http _http;
  DepartamentoApi(this._http);

  Future<DataValues> allDepartamentos() async {
    final result = await _http.request<List<DepartamentoModel>>(
        '/api/departamento/',
        method: HttpMethod.get,
        headers: {
          'X-Api-Key': CredentialsApi.apiKey,
          "Authorization": "Bearer ${await PreferencesUserApp().getAccessToken()}",
        },
        parser: (data) => (data as List).map((e) => DepartamentoModel.fromMap(e)).toList()
    );
    return DataValues (
        modelValueList: result.data,
        errorValue: (result.error!=null)?result.error!.data: null,
        statusCode: result.statusCode
    );
  }


  Future<DataValues> crearDepartamento({required String nombre}) async {
    final result = await _http.request<DepartamentoModel>(
        '/api/departamento/',
        method: HttpMethod.post,
        body: {
          'nombre': nombre
        },
        headers: {
          'X-Api-Key': CredentialsApi.apiKey,
          "Authorization": "Bearer ${await PreferencesUserApp().getAccessToken()}",
        },
        parser: (data) => DepartamentoModel.fromMap(data)
    );
    return DataValues (
        modelValue: result.data,
        errorValue: (result.error!=null)?result.error!.data: null,
        statusCode: result.statusCode
    );
  }

}