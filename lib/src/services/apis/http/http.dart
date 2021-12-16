import 'dart:convert';

import 'package:health_and_hope/src/services/apis/data_source/credentialsApi.dart';
import 'package:health_and_hope/src/services/apis/http/httpMethod.dart';
import 'package:health_and_hope/src/services/apis/http/httpResult.dart';
import 'package:health_and_hope/src/services/apis/http/parseResponse.dart';
import 'package:health_and_hope/src/services/apis/http/sendRequest.dart';
import 'package:health_and_hope/src/utils/logs.dart';

typedef Parser<T> = T Function(dynamic data);


class Http {


  String? baseUrl;

  Http({this.baseUrl});
  Future<HttpResult<T>> request<T>(
    String path,{
      HttpMethod method = HttpMethod.get,
      Map<String, String> headers = const{},
      Map<String, String> queryParameters = const{},
      dynamic body,
      Parser<T>? parser,
      Duration timeOut = const Duration(seconds: 10),
  }) async {
    if (baseUrl ==null || baseUrl!.isEmpty) baseUrl = CredentialsApi.url;
    int? statusCode;
    dynamic data;
    try{
      late Uri url;
      if (path.startsWith("http://") || path.startsWith("https://")){
        url = Uri.parse(path);
      } else {
        url = Uri.parse("$baseUrl$path");
      }

      if (queryParameters.isNotEmpty) {
        url = url.replace(
            queryParameters: {
              ...url.queryParameters,
              ...queryParameters,
            }
        );
      }


      final response = await sendRequest(
        url: url,
        method: method,
        headers: headers,
        body: body,
        timeOut: timeOut,
      );

      String utf8Response = utf8.decode(response.bodyBytes);
      // utf8Response = utf8Response.replaceAll("http://", "https://");
      data = parseReponseBody(utf8Response);

      // Logs.log.i(data);
      // Logs.log.i(response.statusCode);
      statusCode = response.statusCode;

      if (statusCode! >= 400) {
        throw HttpError(
          data: data,
          stackTrace: StackTrace.current,
          exception: null,
        );
      }


      return HttpResult<T>(
          data: parser!=null?parser(data):data,
          statusCode: statusCode,
          error: null
      );
    } catch (e, s) {
      if (e is HttpError) {
        return HttpResult<T>(
          data: null,
          statusCode: statusCode!,
          error: e,
        );
      }
      return HttpResult<T>(
        data: null,
        statusCode: statusCode??-1,
        error: HttpError(
          data: data,
          exception: e,
          stackTrace: s,
        ),
      );
    }
  }
}


