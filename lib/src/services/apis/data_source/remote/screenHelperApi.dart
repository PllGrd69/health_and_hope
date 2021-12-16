import 'package:health_and_hope/src/models/baseModel/dataValues.dart';
import 'package:health_and_hope/src/models/baseModel/models.dart';
import 'package:health_and_hope/src/services/apis/data_source/credentialsApi.dart';
import 'package:health_and_hope/src/services/apis/http/http.dart';
import 'package:health_and_hope/src/services/apis/http/httpMethod.dart';
import 'package:health_and_hope/src/share_prefs/preferencias_usuario.dart';

class ScreenHelperApi {
  final Http _http;
  ScreenHelperApi(this._http);

  Future<DataValues> allScreensHelper() async {
    final result = await _http.request<List<ScreenHelperModel>>(
        '/api/pantallaBienvenida/',
        method: HttpMethod.get,
        headers: {
          'X-Api-Key': CredentialsApi.apiKey,
          "Authorization": "Bearer ${await PreferencesUserApp().getAccessToken()}",
        },
        parser: (data) => (data as List).map((e) => ScreenHelperModel.fromMap(e)).toList()
    );

    return DataValues (
      modelValueList: result.data,
      errorValue: (result.error!=null)?result.error!.data: null,
      statusCode: result.statusCode
    );

  }

}