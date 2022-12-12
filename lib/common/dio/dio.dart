import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:howlook/common/const/data.dart';
import 'package:howlook/common/secure_storage/secure_storage.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio();

  final storage = ref.watch(secureStorageProvider);

  dio.interceptors.add(
    CustomInteceptor(
      storage: storage,
      ref: ref,
    ),
  );

  return dio;
});

class CustomInteceptor extends Interceptor {
  final FlutterSecureStorage storage;
  final Ref ref;

  CustomInteceptor({
    required this.storage,
    required this.ref,
  });

  // 1. 요청을 받을 때
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    print('[REP] [${options.method}], ${options.uri}');
    if (options.headers['accessToken'] == 'true') {
      options.headers.remove('accessToken');

      final token = await storage.read(key: ACCESS_TOKEN_KEY);

      options.headers.addAll({
        'authorization': 'Bearer $token',
      });
    }

    if (options.headers['refreshToken'] == 'true') {
      options.headers.remove('refreshToken');

      final token = await storage.read(key: REFRESH_TOKEN_KEY);

      options.headers.addAll({
        'authorization': 'Bearer $token',
      });
    }

    return super.onRequest(options, handler);
  }

  // 2. 응답을 받을 때
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(
        '[REQ] [${response.requestOptions.method}], ${response.requestOptions.uri}');
    return super.onResponse(response, handler);
  }

  // 3. 에러가 났을 때
  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    print('[ERR] [${err.requestOptions.method}], ${err.requestOptions.uri}');
    // Error 401 -> 재발급

    // refreshToken 없으면 에러 반환
    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);
    if (refreshToken == null) {
      return handler.reject(err);
    }

    final isStatus401 = err.response?.statusCode == 401;
    // access 토큰 재발급 받으려다 나는 오류,,, accessToken 재발급 API 경로 밑에 넣어주기
    final isPathRefresh = err.requestOptions.path == '/refreshToken';

    if (isStatus401 && !isPathRefresh) {
      final dio = new Dio();

      try {
        final resp = await dio.post('http://$API_SERVICE_URI/refreshToken',
            options: Options(
              headers: {
                'authorization': 'Bearer $refreshToken',
                // 'authorization':
              },
            ),
            data: {
              'accessToken':
                  'Bearer ${await storage.read(key: ACCESS_TOKEN_KEY)}',
              'refreshToken': 'Bearer $refreshToken',
            });
        final accessToken = resp.data['accessToken'];

        final options = err.requestOptions;

        // 토큰 변경
        options.headers.addAll({
          'authorization': 'Bearer $accessToken',
        });

        await storage.write(key: ACCESS_TOKEN_KEY, value: accessToken);

        // 요청 재전송
        final response = await dio.fetch(options);

        // 변경된 토큰 값으로 다시 실행
        return handler.resolve(response);
      } on DioError catch (e) {
        return handler.reject(e);
      }
    }

    return super.onError(err, handler);
  }
}
