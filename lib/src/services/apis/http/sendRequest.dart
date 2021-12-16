import 'dart:convert';

import 'package:health_and_hope/src/services/apis/http/httpMethod.dart';
import 'package:http/http.dart' as httpW;

dynamic _parseBody(dynamic body) {
  try {
    return jsonEncode(body);
  } catch (_) {
    return body;
  }
}

sendRequest({
  required Uri url,
  required HttpMethod method,
  required Map<String, String> headers,
  required dynamic body,
  required Duration timeOut,
}) {
  var finalHeaders = {...headers};
  if (method != HttpMethod.get) {
    final contentType = headers['Content-Type'];
    if (contentType == null || contentType.contains("applications/json")) {
      finalHeaders['Content-Type'] = "application/json; charset=utf-8";
      body = _parseBody(body);
    }
  }

  final client = httpW.Client();

  print("$method - $url");
  switch (method) {
    case HttpMethod.get:
      return client.get(
        url,
        headers: finalHeaders,
      ).timeout(timeOut);

    case HttpMethod.post:
      return client.post(
        url,
        headers: finalHeaders,
        body: body
      ).timeout(timeOut);
    case HttpMethod.put:
      return client.put(
        url,
        headers: finalHeaders,
        body: body
      ).timeout(timeOut);
    case HttpMethod.patch:
      return client.patch(
        url,
        headers: finalHeaders,
        body: body
      ).timeout(timeOut);
    case HttpMethod.patch:
      return client.patch(
        url,
        headers: finalHeaders,
        body: body
      ).timeout(timeOut);
    case HttpMethod.delete:
      return client.delete(
        url,
        headers: finalHeaders,
        body: body
      ).timeout(timeOut);
  }
}
