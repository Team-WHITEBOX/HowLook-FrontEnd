import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CustomInteceptor extends Interceptor {
  final FlutterSecureStorage storage;

  CustomInteceptor({
    required this.storage,
  });

  // 1. 요청을 받을 때
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    return onRequest(options, handler);
  }
  // 2. 응답을 받을 때

  // 3. 에러가 났을 때

}
