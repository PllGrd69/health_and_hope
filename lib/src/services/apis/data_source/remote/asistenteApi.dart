
import 'package:health_and_hope/src/models/baseModel/models.dart';
import 'package:health_and_hope/src/models/models/actividadAyudaModel.dart';
import 'package:health_and_hope/src/services/apis/data_source/credentialsApi.dart';
import 'package:health_and_hope/src/services/apis/http/http.dart';
import 'package:health_and_hope/src/services/apis/http/httpMethod.dart';
import 'package:health_and_hope/src/share_prefs/preferencias_usuario.dart';

class AsistenteApi {
  final Http _http;
  AsistenteApi(this._http);

  Future<DataValues> asistentesParticipante({required String idParticipante}) async {
    final result = await _http.request<List<AsistenteModel>>(
      '/api/asistente/',
      method: HttpMethod.get,
      queryParameters: {'participanteAsistente__id': idParticipante},
      headers: {
        'X-Api-Key': CredentialsApi.apiKey,
        "Authorization": "Bearer ${await PreferencesUserApp().getAccessToken()}",
      },
      parser: (data) => (data as List).map((e) => AsistenteModel.fromMap(e)).toList()
    );
    return DataValues (
        modelValueList: result.data,
        errorValue: (result.error!=null)?result.error!.data: null,
        statusCode: result.statusCode
    );
  }

  Future<DataValues> asistentesDisponiblesParticipante({required String idParticipante, required String email, required String dni, required int page}) async {
    final result = await _http.request<AsistentePaginadoModel>(
      '/api/asistentesDisponiblesParticipantes/',
      method: HttpMethod.get,
      queryParameters: {
        'idParticipanteExcludeAsistentes': idParticipante,
        'asistente__email': email,
        'asistente__dni': dni,
        'page': page.toString()
      },
      headers: {
        'X-Api-Key': CredentialsApi.apiKey,
        "Authorization": "Bearer ${await PreferencesUserApp().getAccessToken()}",
      },
      parser: (data) => AsistentePaginadoModel.fromMap(data)
    );
    return DataValues (
        modelValue: result.data,
        errorValue: (result.error!=null)?result.error!.data: null,
        statusCode: result.statusCode
    );
  }

  Future<DataValues> registrarAsistenteParticipante({required String idParticipante, required String idAsistente}) async {
    final result = await _http.request(
      '/api/asistenteParticipanteMod/',
      method: HttpMethod.put,
      body: {
        "asistente": idAsistente,
        "participante": idParticipante
      },
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

  Future<DataValues> eliminarAsistenteParticipante({required String idParticipante, required String idAsistente}) async {
    final result = await _http.request(
      '/api/asistenteParticipanteMod/',
      method: HttpMethod.delete,
      body: {
        "asistente": idAsistente,
        "participante": idParticipante
      },
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

  Future<DataValues> todosAsistentes({required String email, required String dni, required int page}) async {
    final result = await _http.request<AsistentePaginadoModel>(
      '/api/asistentePag/',
      method: HttpMethod.get,
      queryParameters: {
        'asistente__email': email,
        'asistente__dni': dni,
        'page': page.toString()
      },
      headers: {
        'X-Api-Key': CredentialsApi.apiKey,
        "Authorization": "Bearer ${await PreferencesUserApp().getAccessToken()}",
      },
      parser: (data) => AsistentePaginadoModel.fromMap(data)
    );
    return DataValues (
        modelValue: result.data,
        errorValue: (result.error!=null)?result.error!.data: null,
        statusCode: result.statusCode
    );
  }

  Future<DataValues> eliminarAsistente({required String idAsistente}) async {
    final result = await _http.request(
        '/api/asistente/$idAsistente/',
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


}