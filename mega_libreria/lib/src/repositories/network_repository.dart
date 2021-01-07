import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/material.dart';
import 'package:megalibreria/src/repositories/preferences_repository.dart';

class NetworkRepository {
  String baseUrl;
  Dio _network;
  BaseOptions _options;
  PreferencesRepository preferences;
  DioCacheManager _cacheManager;

  NetworkRepository({
    @required this.baseUrl,
    @required this.preferences,
  }) {
    _options = new BaseOptions(
      baseUrl: baseUrl,
    );

    _cacheManager = DioCacheManager(
      CacheConfig(baseUrl: baseUrl),
    );

    _network = Dio(_options);

    _network.interceptors.add(
      InterceptorsWrapper(
        onRequest: (Options options) async {
          final token = await preferences.getToken();

          options.headers['Authorization'] = "Bearer $token";

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

    _network.interceptors.add(_cacheManager.interceptor);
  }

  void addInterceptor(Interceptor interceptor) {
    _network.interceptors.add(interceptor);
  }

  Dio get instance => _network;

  Options cacheOptions({bool forceRefresh = false}) {
    return buildCacheOptions(Duration(days: 7), forceRefresh: forceRefresh);
  }

  void clearCache(){
    _cacheManager.clearAll();
  }
}
