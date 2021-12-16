import 'package:health_and_hope/src/models/baseModel/dataValues.dart';
import 'package:health_and_hope/src/models/models/actividadAyudaModel.dart';
import 'package:health_and_hope/src/services/apis/data_source/credentialsApi.dart';
import 'package:health_and_hope/src/services/apis/http/http.dart';
import 'package:health_and_hope/src/services/apis/http/httpMethod.dart';
import 'package:health_and_hope/src/share_prefs/preferencias_usuario.dart';

class ActividadAyudaApi {
  final Http _http;
  ActividadAyudaApi(this._http);

  Future<DataValues> misActividadesAyuda({required String uuidActividad}) async {
    final result = await _http.request<List<ActividadAyudaModel>>(
        '/api/miActividadAyuda/',
        method: HttpMethod.get,
        queryParameters: {'actividad__id': uuidActividad},
        headers: {
          'X-Api-Key': CredentialsApi.apiKey,
          "Authorization": "Bearer ${await PreferencesUserApp().getAccessToken()}",
        },
        parser: (data) => (data as List).map((e) => ActividadAyudaModel.fromMap(e)).toList()
    );
    return DataValues (
        modelValueList: result.data,
        errorValue: (result.error!=null)?result.error!.data: null,
        statusCode: result.statusCode
    );
  }

}