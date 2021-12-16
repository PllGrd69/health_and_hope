
import 'package:health_and_hope/src/models/baseModel/dataValues.dart';
import 'package:health_and_hope/src/models/models/tarjetaModificacionModel.dart';
import 'package:health_and_hope/src/services/apis/data_source/credentialsApi.dart';
import 'package:health_and_hope/src/services/apis/http/http.dart';
import 'package:health_and_hope/src/services/apis/http/httpMethod.dart';
import 'package:health_and_hope/src/share_prefs/preferencias_usuario.dart';

class TarjetaModificacionApi {
  final Http _http;
  TarjetaModificacionApi(this._http);

  Future<DataValues> misTarjetasMod() async {
    final result = await _http.request<List<TarjetaModificacionModel>>(
        '/api/misTarjetasDeModificacion/',
        method: HttpMethod.get,
        headers: {
          'X-Api-Key': CredentialsApi.apiKey,
          "Authorization": "Bearer ${await PreferencesUserApp().getAccessToken()}",
        },
        parser: (data) => (data as List).map((e) => TarjetaModificacionModel.fromMap(e)).toList()
    );

    return DataValues (
        modelValueList: result.data,
        errorValue: (result.error!=null)?result.error!.data: null,
        statusCode: result.statusCode
    );

  }


  Future<DataValues> tarjetasModifParticipante({required String idParticipante}) async {
    final result = await _http.request<List<TarjetaModificacionModel>>(
        '/api/tarjetaModificacion/',
        method: HttpMethod.get,
        queryParameters: {
          'participante__id': idParticipante
        },
        headers: {
          'X-Api-Key': CredentialsApi.apiKey,
          "Authorization": "Bearer ${await PreferencesUserApp().getAccessToken()}",
        },
        parser: (data) => (data as List).map((e) => TarjetaModificacionModel.fromMap(e)).toList()
    );
    return DataValues (
        modelValueList: result.data,
        errorValue: (result.error!=null)?result.error!.data: null,
        statusCode: result.statusCode
    );

  }

  Future<DataValues> registrarTarjetaModifParticipante({required TarjetaModificacionModel tarjetaModifParticipante}) async {
    final result = await _http.request<TarjetaModificacionModel>(
        '/api/tarjetaModificacion/',
        method: HttpMethod.post,
        body: tarjetaModifParticipante.toMap(),
        headers: {
          'X-Api-Key': CredentialsApi.apiKey,
          "Authorization": "Bearer ${await PreferencesUserApp().getAccessToken()}",
        },
        parser: (data) => TarjetaModificacionModel.fromMap(data)
    );
    return DataValues (
      modelValue: result.data,
      errorValue: (result.error!=null)?result.error!.data: null,
      statusCode: result.statusCode
    );
  }


  Future<DataValues> eliminarTarjetaModifParticipante({required String idTarjetaModif}) async {
    final result = await _http.request(
        '/api/tarjetaModificacion/$idTarjetaModif/',
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

  Future<DataValues> actualizarTarjetaModifParticipante({required TarjetaModificacionModel tarjetaModifParticipante}) async {
    final result = await _http.request<TarjetaModificacionModel>(
      '/api/tarjetaModificacion/${tarjetaModifParticipante.id}/',
      method: HttpMethod.put,
      body: tarjetaModifParticipante.toMap(),
      headers: {
        'X-Api-Key': CredentialsApi.apiKey,
        "Authorization": "Bearer ${await PreferencesUserApp().getAccessToken()}",
      },
        parser: (data) => TarjetaModificacionModel.fromMap(data)
    );
    return DataValues (
      modelValue: result.data,
      errorValue: (result.error!=null)?result.error!.data: null,
      statusCode: result.statusCode
    );
  }

}