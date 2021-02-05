import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:services/src/repositories/spreferences_repository_impl.dart';
import 'package:services/src/utils/constants.dart';

class NetworkRepository {
  String baseUrl;
  Dio _network;
  Dio _networkStripe;
  BaseOptions _options;
  BaseOptions _optionsStripe;
  SPreferencesRepositoryImpl preferences;

  NetworkRepository({
    @required this.baseUrl,
    @required this.preferences,
  }) {
    _options = new BaseOptions(
      baseUrl: baseUrl,
    );

    _network = Dio(_options);

    _network.interceptors.add(InterceptorsWrapper(onRequest: (Options options) async {
      final token = await preferences.getToken();

      options.headers['Authorization'] = "Bearer $token";

      if (options.contentType != "multipart/form-data") {
        options.headers['Content-Type'] = "application/json";
      }

      return options;
    }, onResponse: (Response response) {
      if (response.headers['lat'] != null) {
        preferences.save<double>("lat", double.parse(response.headers['lat'][0]));
        preferences.save<double>("lon", double.parse(response.headers['lon'][0]));
        preferences.save<double>("cost", double.parse(response.headers['cost'][0]));
      }
      return response;
    }));

    _network.interceptors.add(
      DioCacheManager(
        CacheConfig(baseUrl: baseUrl),
      ).interceptor,
    );

    _optionsStripe = BaseOptions(
      baseUrl: STRIPE_API,
    );

    _networkStripe = Dio(_optionsStripe);
    _networkStripe.interceptors.add(
      InterceptorsWrapper(
        onRequest: (Options options) {
          options.headers['Authorization'] = "Bearer $SK";
          options.headers['Content-Type'] = "application/x-www-form-urlencoded";
        },
      ),
    );
  }

  void addInterceptor(Interceptor interceptor) {
    _network.interceptors.add(interceptor);
  }

  Dio get instance => _network;

  Dio get stripe => _networkStripe;

  Options cacheOptions({bool forceRefresh = false}) {
    return buildCacheOptions(Duration(days: 7), forceRefresh: forceRefresh);
  }
}
