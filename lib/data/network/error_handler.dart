import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../pressentation/resources/strings_manager.dart';
import 'failure.dart';

class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handle(dynamic error) {
    if (error is DioError) {
      // dio error so it's an error from response of the API or from dio itself
      failure = _handleError(error);
    } else {
      // default error
      failure = DataSource.DEFAULT.getFailur();
    }
  }
}

Failure _handleError(DioError error) {
  switch (error.type) {
    case DioErrorType.connectTimeout:
      return DataSource.CONNECT_TIMEOUT.getFailur();
    case DioErrorType.sendTimeout:
      return DataSource.SEND_TIMEOUT.getFailur();

    case DioErrorType.receiveTimeout:
      return DataSource.RECIEVE_TIMEOUT.getFailur();
    case DioErrorType.response:
      if (error.response != null &&
          error.response?.statusCode != null &&
          error.response?.statusMessage != null) {
        return Failure(error.response?.statusCode ?? 0,
            error.response?.statusMessage ?? '');
      } else {
        return DataSource.DEFAULT.getFailur();
      }
      break;
    case DioErrorType.cancel:
      return DataSource.CANCEL.getFailur();
    case DioErrorType.other:
      return DataSource.DEFAULT.getFailur();
  }
}

enum DataSource {
  SUCCESS,
  NO_CONTENT,
  BAD_REQUEST,
  FORBIDDEN,
  UNATORISED,
  NOT_FOUND,
  INTERNAL_SERVER_ERROR,
  CONNECT_TIMEOUT,
  CANCEL,
  RECIEVE_TIMEOUT,
  SEND_TIMEOUT,
  CACHE_ERROR,
  NO_INTERNET_CONNECTION,
  DEFAULT,
}

extension DataSourceExtension on DataSource {
  Failure getFailur() {
    switch (this) {
      case DataSource.SUCCESS:
        return Failure(ResponseCode.SUCCESS, AppStrings.SUCCESS.tr());

      case DataSource.NO_CONTENT:
        return Failure(ResponseCode.NO_CONTENT, AppStrings.NO_CONTENT.tr());

      case DataSource.BAD_REQUEST:
        return Failure(ResponseCode.BAD_REQUEST, AppStrings.BAD_REQUEST.tr());
      case DataSource.FORBIDDEN:
        return Failure(ResponseCode.FORBIDDEN, AppStrings.FORBIDDEN.tr());
      case DataSource.UNATORISED:
        return Failure(ResponseCode.UNATORISED, AppStrings.UNATORISED.tr());
      case DataSource.NOT_FOUND:
        return Failure(ResponseCode.NOT_FOUND, AppStrings.NOT_FOUND.tr());
      case DataSource.INTERNAL_SERVER_ERROR:
        return Failure(ResponseCode.INTERNAL_SERVER_ERROR,
            AppStrings.INTERNAL_SERVER_ERROR.tr());
      case DataSource.CONNECT_TIMEOUT:
        return Failure(
            ResponseCode.CONNECT_TIMEOUT, AppStrings.CONNECT_TIMEOUT.tr());
      case DataSource.CANCEL:
        return Failure(ResponseCode.CANCEL, AppStrings.CANCEL.tr());
      case DataSource.RECIEVE_TIMEOUT:
        return Failure(
            ResponseCode.RECIEVE_TIMEOUT, AppStrings.RECIEVE_TIMEOUT.tr());
      case DataSource.SEND_TIMEOUT:
        return Failure(ResponseCode.SEND_TIMEOUT, AppStrings.SEND_TIMEOUT.tr());
      case DataSource.CACHE_ERROR:
        return Failure(ResponseCode.CACHE_ERROR, AppStrings.CACHE_ERROR.tr());
      case DataSource.NO_INTERNET_CONNECTION:
        return Failure(ResponseCode.NO_INTERNET_CONNECTION,
            AppStrings.NO_INTERNET_CONNECTION.tr());
      case DataSource.DEFAULT:
        return Failure(ResponseCode.DEFAULT, AppStrings.DEFAULT.tr());
    }
  }
}

class ResponseCode {
  static const int SUCCESS = 200; // success with data
  static const int NO_CONTENT = 201; // success with no data (no content)
  static const int BAD_REQUEST = 400; // failure, API rejected request
  static const int UNATORISED = 401; // failure, user is not authorised
  static const int FORBIDDEN = 403; // failure, API rejected request
  static const int INTERNAL_SERVER_ERROR = 500; // failure, crash in server side
  static const int NOT_FOUND = 404; //failure , not found

  // local status code
  static const int CONNECT_TIMEOUT = -1;
  static const int CANCEL = -2;
  static const int RECIEVE_TIMEOUT = -3;
  static const int SEND_TIMEOUT = -4;
  static const int CACHE_ERROR = -5;
  static const int NO_INTERNET_CONNECTION = -6;
  static const int DEFAULT = -7;
}

class ApiInternalStatus {
  static const int SUCCESS = 0;
  static const int FAILURE = 1;
}
