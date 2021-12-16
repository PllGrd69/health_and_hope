import 'dart:convert';

import 'package:health_and_hope/src/models/baseModel/models.dart';
import 'package:health_and_hope/src/services/service_apis/conection.dart';
import 'package:http/http.dart' as http;


class ScreensAppCustomHelperServiceApi {

  Future<DataValues> allScreensHelper() async {
    final url = Uri.https(ApiConnection.getUrlApi(), 'api/pantallaBienvenida/');
    final res = await http.get(
        url,
        headers: await ApiConnection.getHeaderApiKey(),
    );
    DataValues dataValues;
    if(res.statusCode==200 || res.statusCode==201) {
      final values = (json.decode(utf8.decode(res.bodyBytes)) as List).map((e) => ScreenHelperModel.fromMap(e)).toList();
      dataValues = DataValues(
        modelValueList: values,
      );
    } else {
      dataValues = DataValues(
          errorValue: json.decode(utf8.decode(res.bodyBytes))
      );
    }
    dataValues.statusCode = res.statusCode;
    return dataValues;
  }

}