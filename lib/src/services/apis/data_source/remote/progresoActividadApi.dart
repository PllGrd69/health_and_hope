import 'package:health_and_hope/src/models/baseModel/dataValues.dart';
import 'package:health_and_hope/src/models/baseModel/models.dart';
import 'package:health_and_hope/src/models/models/progresoActividadModel.dart';
import 'package:health_and_hope/src/services/apis/data_source/credentialsApi.dart';
import 'package:health_and_hope/src/services/apis/http/http.dart';
import 'package:health_and_hope/src/services/apis/http/httpMethod.dart';
import 'package:health_and_hope/src/share_prefs/preferencias_usuario.dart';
import 'package:health_and_hope/src/utils/logs.dart';

class ProgresoActividadApi {
  final Http _http;
  ProgresoActividadApi(this._http);

  Future<DataValues> miProgresoActividad() async {
    final result = await _http.request<List<ProgresoActividadDiarioModel>>(
        '/api/miProgresoSemanal/',
        method: HttpMethod.get,
        headers: {
          'X-Api-Key': CredentialsApi.apiKey,
          "Authorization": "Bearer ${await PreferencesUserApp().getAccessToken()}",
        },
        parser: (data){
          print(data);
          return (data as List).map((e) => ProgresoActividadDiarioModel.fromMap(e)).toList();
        }
    );
    final error = (result.error!=null)? result.error!.data : null;
    return DataValues (
        modelValueList: result.data,
        errorValue: error,
        statusCode: result.statusCode
    );
  }

  Future<DataValues> miProgresoSemanal({required String uuidTarjeta}) async {
    final result = await _http.request<List<ProgresoActividadDiarioModel>>(
        '/api/miProgresoSemanal/',
        method: HttpMethod.get,
        queryParameters: {
          'tarjeta_id': uuidTarjeta
        },
        headers: {
          'X-Api-Key': CredentialsApi.apiKey,
          "Authorization": "Bearer ${await PreferencesUserApp().getAccessToken()}",
        },
        parser: (data){
          return (data as List).map((e) => ProgresoActividadDiarioModel.fromMap(e)).toList();
        }
    );
    return DataValues (
        modelValueList: result.data,
        errorValue: (result.error!=null)? result.error!.data : null,
        statusCode: result.statusCode
    );
  }


  Future<DataValues> misTarjetasProgresoActividad() async {
    final result = await _http.request<List<ProgresoActividadDiarioModel>>(
        '/api/miCalendarioProgreso/',
        method: HttpMethod.get,
        headers: {
          'X-Api-Key': CredentialsApi.apiKey,
          "Authorization": "Bearer ${await PreferencesUserApp().getAccessToken()}",
        },
        parser: (data)=>(data as List).map((e) => ProgresoActividadDiarioModel.fromMap(e)).toList()
    );
    return DataValues (
        modelValueList: result.data,
        errorValue: (result.error!=null)? result.error!.data : null,
        statusCode: result.statusCode
    );
  }

}