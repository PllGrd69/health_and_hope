
import 'package:health_and_hope/src/models/baseModel/models.dart';
import 'package:health_and_hope/src/models/models/actividadAyudaModel.dart';
import 'package:health_and_hope/src/services/apis/data_source/credentialsApi.dart';
import 'package:health_and_hope/src/services/apis/http/http.dart';
import 'package:health_and_hope/src/services/apis/http/httpMethod.dart';
import 'package:health_and_hope/src/share_prefs/preferencias_usuario.dart';

class PersonalDepartamentoApi {
  final Http _http;
  PersonalDepartamentoApi(this._http);

  Future<DataValues> allPersonalDepartamento({required String uuidDepartamento,required int page}) async {
    final result = await _http.request<PersonalDepartamentoPaginadoModel>(
        '/api/personalDepartamento/',
        method: HttpMethod.get,
        queryParameters: {
          'page': page.toString(),
          'departamento__id': uuidDepartamento,
        },
        headers: {
          'X-Api-Key': CredentialsApi.apiKey,
          "Authorization": "Bearer ${await PreferencesUserApp().getAccessToken()}",
        },
        parser: (data) => PersonalDepartamentoPaginadoModel.fromMap(data)
    );
    return DataValues (
        modelValue: result.data,
        errorValue: (result.error!=null)?result.error!.data: null,
        statusCode: result.statusCode
    );
  }

  Future<DataValues> allPersonalDepDisponible({required String idDepartamento}) async {
    final result = await _http.request<List<PersonalModel>>(
        '/api/personalDisponibleDep/',
        method: HttpMethod.get,
        queryParameters: {'idDepartamento':idDepartamento},
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


  Future<DataValues> registrarPersonalDepartamento({required String uuidDepartamento, required String uuidPersonal}) async {
    final result = await _http.request<PersonalDepartamentoPaginadoModel>(
        '/api/personalDepartamento/',
        method: HttpMethod.post,
        body: {
          "personalDepartamento": uuidPersonal,
          "departamento": uuidDepartamento
        },
        headers: {
          'X-Api-Key': CredentialsApi.apiKey,
          "Authorization": "Bearer ${await PreferencesUserApp().getAccessToken()}",
        },
        parser: (data) => PersonalDepartamentoPaginadoModel.fromMap(data)
    );
    return DataValues (
        modelValue: result.data,
        errorValue: (result.error!=null)?result.error!.data: null,
        statusCode: result.statusCode
    );
  }

  Future<DataValues> eliminarPersonalDep({required String uuidPersonalDep}) async {
    final result = await _http.request(
        '/api/personalDepartamento/$uuidPersonalDep/',
        method: HttpMethod.delete,
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


  Future<DataValues> personalDisponibleParticipante({required String idParticipante, required String dni, required String email, required int page}) async {
    final result = await _http.request<PersonalDepartamentoPaginadoModel>(
        '/api/personalDepDisponiblesParticipante/',
        method: HttpMethod.get,
        queryParameters: {
          'idParticipanteExcludePromotor': idParticipante,
          'personalDepartamento__personal__email': email,
          'personalDepartamento__personal__dni': dni,
          'page': page.toString()
        },
        headers: {
          'X-Api-Key': CredentialsApi.apiKey,
          "Authorization": "Bearer ${await PreferencesUserApp().getAccessToken()}",
        },
        parser: (data) => PersonalDepartamentoPaginadoModel.fromMap(data)
    );
    return DataValues (
        modelValue: result.data,
        errorValue: (result.error!=null)?result.error!.data: null,
        statusCode: result.statusCode
    );
  }
}