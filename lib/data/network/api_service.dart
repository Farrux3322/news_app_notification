
import 'package:dio/dio.dart';
import 'package:e_commerce/data/models/universal_response.dart';
import 'package:e_commerce/utils/const.dart';
import 'package:e_commerce/utils/extension.dart';
import 'package:flutter/cupertino.dart';

class ApiService {
  final _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "key=$apiKey"
      },
      connectTimeout: Duration(seconds: TimeOutConstants.connectTimeout),
      receiveTimeout: Duration(seconds: TimeOutConstants.receiveTimeout),
      sendTimeout: Duration(seconds: TimeOutConstants.sendTimeout),
    ),
  );

  ApiService() {
    _init();
  }

  _init() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onError: (error, handler) async {
          //error.response.statusCode
          debugPrint("ERRORGA KIRDI:${error.message} and ${error.response}");
          return handler.next(error);
        },
        onRequest: (requestOptions, handler) async {
          debugPrint("SO'ROV  YUBORILDI :${requestOptions.path}");
          return handler.next(requestOptions);
        },
        onResponse: (response, handler) async {
          debugPrint("JAVOB  KELDI :${response.requestOptions.path}");
          return handler.next(response);
        },
      ),
    );
  }

  Future<UniversalData> postNotification(
      {required String title,
        required String description,
        required String image}) async {
    Response response;
    try {
      response = await _dio.post("/fcm/send", data: {
        "to": "/topics/news",
        "notification": {"title": "NEWS APP", "body": "YANGILIKLAR DUNYOSI"},
        "data": {"title": title, "body": description, "image": image}
      });

      if ((response.statusCode! >= 200) && (response.statusCode! < 300)) {
        return UniversalData(data: response.data);
      }
      return UniversalData(error: "Other Error");
    } on DioException catch (e) {
      return getDioCustomError(e);
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }
}
