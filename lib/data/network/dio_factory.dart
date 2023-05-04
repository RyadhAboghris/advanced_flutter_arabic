import 'package:advanced_flutter_arabic/app/app_prefs.dart';
import 'package:advanced_flutter_arabic/app/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const String APPLICATION_JSON = 'application/json';
const String CONTENT_TYPE = 'content-type';
const String ACCEPT = 'accept';
const String AUTHERIZATION = 'authorization';
const String DEFAULT_LANGUAGE = 'language';

class DioFactory {

  AppPreferences _appPreferences;
  DioFactory(this._appPreferences);


  Future<Dio> getDio() async {
    Dio dio = Dio();

String language = await _appPreferences.getAppLanguage();
    Map<String, String> headers = {
      CONTENT_TYPE: APPLICATION_JSON,
      ACCEPT: APPLICATION_JSON,
      AUTHERIZATION: Constants.token,
      DEFAULT_LANGUAGE: language, // todo get lang from app prefs
    };

    dio.options = BaseOptions(
      baseUrl: Constants.baseUrl,
      headers: headers,
      receiveTimeout:Constants.api_time_out,
      sendTimeout: Constants.api_time_out,
    );
    // it's debug mode so print app logs
    if (kReleaseMode) {
      print('no logs in release mode');
    } else {
      dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
      ));
    }

    return dio;
  }
}
