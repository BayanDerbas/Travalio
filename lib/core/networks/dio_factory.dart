import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import '../routes/app_routes.dart';
import 'api_constant.dart';

class DioFactory {
  DioFactory._();

  static Dio? dio;
  static final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  static Dio getDio() {
    if (dio == null) {
      dio = Dio()
        ..options.connectTimeout = const Duration(seconds: 15)
        ..options.receiveTimeout = const Duration(seconds: 15)
        ..options.headers = {'Accept': 'application/json'};

      dio!.interceptors.add(InterceptorsWrapper(
        onError: (DioException error, ErrorInterceptorHandler handler) async {
          if (error.response?.statusCode == 401) {
            final refreshToken = await _secureStorage.read(key: 'refresh_token');
            if (refreshToken != null) {
              try {
                final response = await dio!.post(
                  '${ApiConstant.baseUrl}/token/refresh/',
                  data: {'refresh': refreshToken},
                );
                final newAccessToken = response.data['access'];
                await _secureStorage.write(key: 'access_token', value: newAccessToken);
                dio!.options.headers['Authorization'] = 'Bearer $newAccessToken';
                return handler.resolve(await dio!.fetch(error.requestOptions));
              } catch (e) {
                await _secureStorage.deleteAll();
                if (error.requestOptions.extra.containsKey('context')) {
                  final context = error.requestOptions.extra['context'] ;
                  context.go(AppRoutes.login);
                }
                return handler.reject(error);
              }
            }
          }
          return handler.next(error);
        },
      ));
    }
    return dio!;
  }

  static Future<void> setToken(String token) async {
    await _secureStorage.write(key: 'access_token', value: token);
    dio?.options.headers = {'Authorization': 'Bearer $token'};
  }

  static Future<void> loadToken() async {
    final token = await _secureStorage.read(key: 'access_token');
    print('[loadToken] token: $token');
    if (token != null) {
      getDio();
      dio?.options.headers['Authorization'] = 'Bearer $token';
    } else {
      print('[loadToken] No token found.');
    }
  }
  static Future<String?> readToken() async {
    return await _secureStorage.read(key: 'access_token');
  }

  static Future<void> clearToken() async {
    await _secureStorage.delete(key: 'access_token');
    dio?.options.headers.remove('Authorization');
  }
}