
import 'package:health_and_hope/src/models/baseModel/models.dart';
import 'package:health_and_hope/src/models/models/actividadAyudaModel.dart';
import 'package:health_and_hope/src/services/apis/data_source/credentialsApi.dart';
import 'package:health_and_hope/src/services/apis/http/http.dart';
import 'package:health_and_hope/src/services/apis/http/httpMethod.dart';
import 'package:health_and_hope/src/share_prefs/preferencias_usuario.dart';

class ParticipanteApi {
  final Http _http;
  ParticipanteApi(this._http);

  Future<DataValues> allParticipantes({required int page, required String email, required String dni}) async {

    final result = await _http.request<ParticipantePaginadoModel>(
      '/api/participante/',
      method: HttpMethod.get,
      queryParameters: {
        'page':page.toString(),
        'participante__email': email,
        'participante__dni': dni
      },
      headers: {
        'X-Api-Key': CredentialsApi.apiKey,
        "Authorization": "Bearer ${await PreferencesUserApp().getAccessToken()}",
      },
      parser: (data) => ParticipantePaginadoModel.fromMap(data)
    );
    return DataValues (
        modelValue: result.data,
        errorValue: (result.error!=null)?result.error!.data: null,
        statusCode: result.statusCode
    );
  }

  Future<DataValues> eliminarParticipante({required String idParticipante}) async {
    final result = await _http.request(
        '/api/participante/$idParticipante/',
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