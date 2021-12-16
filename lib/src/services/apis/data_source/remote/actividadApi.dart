import 'package:health_and_hope/src/models/baseModel/dataValues.dart';
import 'package:health_and_hope/src/models/baseModel/models.dart';
import 'package:health_and_hope/src/models/models/actividadModel.dart';
import 'package:health_and_hope/src/services/apis/data_source/credentialsApi.dart';
import 'package:health_and_hope/src/services/apis/http/http.dart';
import 'package:health_and_hope/src/services/apis/http/httpMethod.dart';
import 'package:health_and_hope/src/share_prefs/preferencias_usuario.dart';

class ActividadesApi {
  final Http _http;
  ActividadesApi(this._http);

  Future<DataValues> misActividadesModif(String uidTarjetaModif) async {
    final result = await _http.request<List<ActividadUsuarioModel>>(
        '/api/miActividadeUsuarioHoy/',
        method: HttpMethod.get,
        queryParameters: {
          'actividadFecha__tarjetaModificacion__id': uidTarjetaModif
        },
        headers: {
          'X-Api-Key': CredentialsApi.apiKey,
          "Authorization": "Bearer ${await PreferencesUserApp().getAccessToken()}",
        },
        parser: (data) => (data as List).map((e) => ActividadUsuarioModel.fromMap(e)).toList()
    );
    return DataValues (
        modelValueList: result.data,
        errorValue: (result.error!=null)?result.error!.data: null,
        statusCode: result.statusCode
    );

  }


  Future<DataValues> cambiarMiEstadoActividad({required String uuidEstado, required String uuidActividad}) async {
    final result = await _http.request<ActividadModel>(
        '/api/miActividadeUsuarioHoy/$uuidActividad/',
        method: HttpMethod.put,
        body: {"estadoActividad": uuidEstado},
        headers: {
          'X-Api-Key': CredentialsApi.apiKey,
          "Authorization": "Bearer ${await PreferencesUserApp().getAccessToken()}",
        },
        parser: (data) => ActividadModel.fromMap(data)
    );
    return DataValues (
        modelValue: result.data,
        errorValue: (result.error!=null)?result.error!.data: null,
        statusCode: result.statusCode
    );

  }

}