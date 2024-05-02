import 'package:dio/dio.dart';

Dio configureOptions () {
  final options = BaseOptions(
    baseUrl: "http://192.168.43.215:3030/",
    //baseUrl : "http://192.168.1.24:3030",
    sendTimeout: Duration(seconds: 30),
    receiveTimeout: Duration(seconds: 30)
  );

  final dio = Dio(options);
  return dio;
}
