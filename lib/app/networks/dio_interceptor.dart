import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:accounting_app/app/cache/cache_keys.dart';
import 'package:accounting_app/app/cache/share_preference.dart';
import 'package:accounting_app/app/config/base_url_config.dart';

class DioInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final statusCode = err.response?.statusCode;
    final data = err.response?.data;
    debugPrint('statusCode $statusCode');
    debugPrint('statusCode ${err.response?.data}');
    // debugPrint('error data ${(data as ResponseBody).statusMessage}');

    // if (statusCode == 401) {
    //   try {
    //     final newToken = await DioClient().refreshToken();
    //     if (newToken != null) {
    //       // Save new token
    //       Hive.box(CacheKeys.authKey).put(CacheKeys.tokenKey, newToken);

    //       // Clone the original request with the new token
    //       final options = err.requestOptions;
    //       options.headers['Authorization'] = 'Bearer $newToken';

    //       final retryResponse = await Dio().fetch(options);
    //       return handler.resolve(retryResponse);
    //     } else {
    //       // Token refresh failed
    //       return handler.reject(err);
    //     }
    //   } catch (e) {
    //     debugPrint('Token refresh failed: $e');
    //     return handler.reject(err);
    //   }
    // }
    switch (statusCode) {
      case 401:
        // appContext?.read<AuthBloc>().add(LogoutEvent());
        handler.reject(err); // Or handle it differently
        break;
      case 400:
        final errorMessage = _parseErrorMessage(data);
        handler.reject(
          DioException(
            requestOptions: err.requestOptions,
            error: errorMessage,
            response: err.response,
          ),
        );
        break;
      case 404:
        // Handle not found error
        if (err.response?.data is Map) {
          handler.reject(
            DioException(
              requestOptions: err.requestOptions,
              error: err.response?.data?['message'] ?? 'Resource not found',
              response: err.response,
            ),
          );
        } else {
          handler.reject(
            DioException(
              requestOptions: err.requestOptions,
              error: err.response?.data?.statusMessage ?? 'Resource not found',
              response: err.response,
            ),
          );
        }
        break;
      case 500:
        // Handle server error
        handler.reject(
          DioException(
            requestOptions: err.requestOptions,
            error: 'Internal server error',
            response: err.response,
          ),
        );
        break;
      default:
        handler.reject(err);
    }
  }

  String _parseErrorMessage(dynamic data) {
    try {
      if (data is Map<String, dynamic>) {
        return data['message'] ?? data['error'] ?? 'Bad request';
      }
      return 'Bad request';
    } catch (e) {
      return 'Bad request';
    }
  }

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final noAuthEndpoints = [BaseUrlConfig.signIn, BaseUrlConfig.signUp];

    final isS3Url = options.uri.host.contains('s3.amazonaws.com');

    final isAuthRequired =
        !noAuthEndpoints.any(
          (endpoint) =>
              options.path.endsWith(endpoint) ||
              options.path.contains(endpoint),
        ) &&
        !isS3Url;

    final headers = <String, dynamic>{};
    if (options.responseType != ResponseType.stream) {
      headers['Content-Type'] = 'application/json';
      headers['Accept'] = 'application/json';
    }

    if (isAuthRequired) {
      final token = await _getAuthToken();
      debugPrint('Token: $token');
      if (token != null) {
        headers['Authorization'] = 'Bearer $token';
      }
    }

    debugPrint('Request: ${options.method} ${options.uri}');
    debugPrint('Request headers: $headers');
    options.headers.addAll(headers);

    handler.next(options);
  }

  Future<String?> _getAuthToken() async {
    return await AppSharedPreferences.instance.getShareString(
      CacheKeys.tokenKey,
    );
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint('Response: ${response.data}');
    handler.next(response);
  }
}
