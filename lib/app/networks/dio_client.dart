import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:accounting_app/app/cache/cache_keys.dart';
import 'package:accounting_app/app/cache/share_preference.dart';
import 'package:accounting_app/app/config/base_url_config.dart';
import 'package:accounting_app/app/networks/api_exceptions.dart';
import 'package:accounting_app/app/networks/dio_interceptor.dart';
// import 'package:open_filex/open_filex.dart';
// import 'package:path_provider/path_provider.dart';

class DioClient {
  final Dio _dio;
  DioClient() : _dio = Dio() {
    bool validateStatus(int? status) {
      return (status ?? 500) < 400; // Accepts 2xx/3xx
    }

    final baseOption = BaseOptions(
      baseUrl: BaseUrlConfig.baseUrl,
      // connectTimeout: const Duration(seconds: 0),
      // receiveTimeout: const Duration(seconds: 10),
      validateStatus: validateStatus,
    );

    _dio.options = baseOption;

    _dio.interceptors.addAll([DioInterceptor()]);
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      debugPrint('path $path');
      debugPrint('queryParameters $queryParameters');
      final response = await _dio.get(path, queryParameters: queryParameters);
      debugPrint('response for $path:: $response');

      return response;
    } on Exception catch (e) {
      throw ApiException.getException(e);
    }
  }

  Future<Response> post(
    String path, {
    Map<String, dynamic>? queryParameters,
    dynamic data,
  }) async {
    try {
      debugPrint('path $path');
      log('request ${jsonEncode(data)}');
      debugPrint('queryParameters $queryParameters');
      final response = await _dio.post(
        path,
        queryParameters: queryParameters,
        data: data,
      );
      debugPrint(
        'response for $path:: $response status code ${response.statusCode}',
      );
      debugPrint('response for $path:: $response');
      return response;
    } on Exception catch (e) {
      debugPrint('error for $path:: status code ${e.toString()}');
      throw ApiException.getException(e);
    }
  }

  Future<String?> refreshToken() async {
    final refreshToken = await AppSharedPreferences.instance.getShareString(
      CacheKeys.refreshTokenKey,
    );
    if (refreshToken == null) return null;

    try {
      final response = await _dio.post(
        BaseUrlConfig.refreshToken,
        data: {'refreshToken': refreshToken},
      );
      final newToken = response.data['access_token'];
      return newToken;
    } catch (e) {
      debugPrint('Refresh token request failed: $e');
      return null;
    }
  }

  Future<Response> patch(
    String path, {
    Map<String, dynamic>? queryParameters,
    dynamic data,
  }) async {
    debugPrint('path $path');
    debugPrint('request $data');
    debugPrint('queryParameters $queryParameters');
    // throw UnimplementedError();
    return _dio.patch(path, queryParameters: queryParameters, data: data);
  }

  Future<Response> delete(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    return _dio.delete(path, queryParameters: queryParameters);
  }

  Future<void> download(
    String url,
    String savePath, {
    CancelToken? cancelToken,
    Function(int, int)? onReceiveProgress,
    Map<String, dynamic>? headers,
  }) async {
    try {
      debugPrint('Downloading file from: $url');
      debugPrint('Saving to: $savePath');
      debugPrint('Headers: $headers');
      final response = await _dio.download(
        url,
        savePath,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
        options: Options(
          headers: headers,
          responseType: ResponseType.stream, // Ensure streaming for downloads
          validateStatus: (status) {
            debugPrint('Download response status: $status');
            return (status ?? 500) < 400;
          },
        ),
      );
      debugPrint(
        'Download completed for $url with status: ${response.statusCode}',
      );
      debugPrint('Response headers: ${response.headers}');
    } on DioException catch (e) {
      debugPrint('Download error: $e');
      debugPrint('Response data: ${e.response?.data}');
      debugPrint('Response headers: ${e.response?.headers}');
      throw ApiException.getException(e);
    }
  }

  // String? getFileExtensionFromContentType(String? contentType) {
  //   if (contentType == null) return null;
  //   debugPrint('Content-Type: $contentType');
  //   switch (contentType) {
  //     case 'application/pdf':
  //       return '.pdf';
  //     case 'image/jpeg':
  //       return '.jpg';
  //     case 'image/png':
  //       return '.png';
  //     case 'text/plain':
  //     case 'text/html':
  //       return '.txt';
  //     case 'application/vnd.openxmlformats-officedocument.wordprocessingml.document':
  //       return '.docx';
  //     case 'application/vnd.ms-excel':
  //       return '.xls';
  //     case 'application/zip':
  //       return '.zip';
  //     // Add more MIME types as needed
  //     default:
  //       return null;
  //   }
  // }
  Future<Response> downloadFile(String path, {String savePath = ''}) async {
    final downloadResponse = await _dio.download(
      path,
      savePath,
      onReceiveProgress: (received, total) {
        if (total != -1) {
          debugPrint('${(received / total * 100).toStringAsFixed(0)}%');
        }
      },
    );
    // Log the file type and

    return downloadResponse;
  }
}

extension ResponseExtension on Response {
  bool get isSuccess {
    final is200 = statusCode == HttpStatus.ok;
    final is201 = statusCode == HttpStatus.created;
    return is201 || is200;
  }
}
