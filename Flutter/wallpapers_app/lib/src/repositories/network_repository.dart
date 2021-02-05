import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/material.dart';

class NetworkRepository {
  String baseUrl;
  Dio _network;
  BaseOptions _options;
  DioCacheManager _cacheManager;

  NetworkRepository({
    @required this.baseUrl,
  }) {
    _options = new BaseOptions(
      baseUrl: baseUrl,
    );

    _cacheManager = DioCacheManager(
      CacheConfig(baseUrl: baseUrl),
    );

    _network = Dio(_options);
    _network.interceptors.add(_cacheManager.interceptor);
  }

  void addInterceptor(Interceptor interceptor) {
    _network.interceptors.add(interceptor);
  }

  Dio get instance => _network;

  Options cacheOptions({bool forceRefresh = false}) {
    return buildCacheOptions(Duration(days: 1), forceRefresh: forceRefresh);
  }

  void clearCache(){
    _cacheManager.clearAll();
  }
}
