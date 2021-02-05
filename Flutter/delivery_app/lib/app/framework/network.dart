import 'package:app/app/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/material.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class Network {
  Dio _network;
  BaseOptions _options;
  DioCacheManager _cacheManager;
  final Future<String> Function() getToken;

  Network(
      {@required String baseUrl,
      this.getToken,
      String tokenType = "Bearer",
      List<Interceptor> interceptors,
      bool cache = true,
      bool token = true,
      DioCacheManager cacheManager}) {
    _options = new BaseOptions(
      baseUrl: baseUrl,
    );

    _cacheManager = cacheManager;

    _network = Dio(_options);

    if ((interceptors == null || interceptors.isEmpty) && token) {
      _network.interceptors.add(
        InterceptorsWrapper(
          onRequest: (Options options) async {
            final token = await getToken();

            if (token != null && token.isNotEmpty)
              options.headers['Authorization'] = "$tokenType $token";

            if (options.contentType != "multipart/form-data") {
              options.headers['Content-Type'] = "application/json";
            }

            return options;
          },
          onResponse: (Response response) {
            return response;
          },
        ),
      );
    } else if (interceptors != null && interceptors.isNotEmpty) {
      _network.interceptors.addAll(interceptors);
    }

    if (DEBUG) {
      _network.interceptors.add(
        PrettyDioLogger(
          request: true,
          requestBody: true,
          requestHeader: true,
          responseBody: true,
        ),
      );
    }

    if (cache) _network.interceptors.add(_cacheManager.interceptor);
  }

  void addInterceptor(Interceptor interceptor) {
    _network.interceptors.add(interceptor);
  }

  Dio get instance => _network;

  Options cacheOptions({bool forceRefresh = false}) {
    return buildCacheOptions(const Duration(hours: 1), forceRefresh: forceRefresh);
  }

  void clearCache() {
    _cacheManager.clearAll();
  }
}
