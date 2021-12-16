class HttpResult<T>{

  final T? data;
  final int statusCode;
  final HttpError? error;

  HttpResult({
    required this.data,
    required this.statusCode,
    required this.error
  });

}

class ResultData{
  final HttpResult? resultData;
  final HttpError? error;

  ResultData({
    this.resultData,
    this.error
  });
}

class HttpError {
  final Object? exception;
  final StackTrace stackTrace;
  final dynamic data;

  HttpError({
    required this.exception,
    required this.stackTrace,
    required this.data
  });
}