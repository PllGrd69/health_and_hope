
import 'package:health_and_hope/src/models/baseModel/models.dart';
import 'package:health_and_hope/src/models/models/actividadAyudaModel.dart';
import 'package:health_and_hope/src/services/apis/data_source/credentialsApi.dart';
import 'package:health_and_hope/src/services/apis/http/http.dart';
import 'package:health_and_hope/src/services/apis/http/httpMethod.dart';
import 'package:health_and_hope/src/share_prefs/preferencias_usuario.dart';

class PromotorApi {
  final Http _http;
  PromotorApi(this._http);

  Future<DataValues> promotoresParticipante({required String idParticipante}) async {
    final result = await _http.request<List<PromotorParticipanteModel>>(
      '/api/promotorParticipante/',
      method: HttpMethod.get,
      queryParameters: {'participante__id': idParticipante},
      headers: {
        'X-Api-Key': CredentialsApi.apiKey,
        "Authorization": "Bearer ${await PreferencesUserApp().getAccessToken()}",
      },
      parser: (data) => (data as List).map((e) => PromotorParticipanteModel.fromMap(e)).toList()
    );
    return DataValues (
        modelValueList: result.data,
        errorValue: (result.error!=null)?result.error!.data: null,
        statusCode: result.statusCode
    );
  }


  Future<DataValues> registrarPromotorParticipante({required String idParticipante, required String idPromotorParticipante}) async {
    final result = await _http.request(
        '/api/promotorParticipante/',
        method: HttpMethod.post,
        body: {
          "promotorParticipante": idPromotorParticipante,
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

  Future<DataValues> eliminarPromotorParticipante({required String idPromotorParticipante}) async {
    final result = await _http.request(
      '/api/promotorParticipante/$idPromotorParticipante/',
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