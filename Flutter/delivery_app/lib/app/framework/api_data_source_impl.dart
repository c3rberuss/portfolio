import 'dart:async';

import 'package:app/app/framework/network.dart';
import 'package:app/app/models/service_model.dart';
import 'package:app/app/models/store_model.dart';
import 'package:app/app/models/area_model.dart';
import 'package:app/core/data/api_data_source.dart';
import 'package:app/core/domain/resource.dart';
import 'package:app/core/domain/service.dart';
import 'package:app/core/domain/store.dart';
import 'package:app/core/domain/area.dart';
import 'package:app/core/exceptions/api_exceptions.dart';
import 'package:dio/dio.dart';

class ApiDataSourceImpl extends ApiDataSource {
  final Network _network;

  ApiDataSourceImpl(this._network);

  @override
  Future<Resource<ServicesResponse>> fetchServices({int page = 0, bool refresh = false}) async {
    try {
      final response = await _network.instance.get(
        "/v1/services/",
        queryParameters: {
          "page": page,
          "size": 10,
        },
        options: _network.cacheOptions(forceRefresh: refresh),
      );

      final data = ServicesResponseModel.fromJson(response.data);

      return Success<ServicesResponse>(data);
    } on DioError catch (e) {
      return Failure<ServicesResponse, DioError>(e);
    }
  }

  @override
  Future<Resource<StoresResponse>> fetchStores(int serviceId,
      {int page = 0, bool refresh = false}) async {
    try {
      final response = await _network.instance.get(
        "/v1/services/$serviceId/stores",
        queryParameters: {
          "page": page,
          "size": 10,
        },
        options: _network.cacheOptions(forceRefresh: refresh),
      );

      final data = StoresResponseModel.fromJson(response.data);

      return Success<StoresResponse>(data);
    } on DioError catch (e) {
      return Failure<StoresResponse, DioError>(e);
    }
  }

  @override
  Future<Resource<List<Area>>> fetchServiceArea(int departmentId) async {
    try {
      final response = await _network.instance.get(
        "/v1/service-area/deparmentId/$departmentId",
        options: _network.cacheOptions(forceRefresh: true),
      );

      final responseParsed = AreasResponseModel.fromJson(response.data);

      if (responseParsed.status == 200) {
        return Success<List<Area>>(responseParsed.data);
      } else if (responseParsed.status == 401) {
        return Failure<List<Area>, ApiException>(
          UnauthorizedException(),
        );
      } else if (responseParsed.status == 403) {
        return Failure<List<Area>, ApiException>(
          ForbiddenException(),
        );
      } else if (responseParsed.status == 404) {
        return Failure<List<Area>, ApiException>(
          NotFoundException(),
        );
      }
    } on DioError catch (_) {
      return Failure<List<Area>, ApiException>(
        ApiException(),
      );
    }

    return Failure<List<Area>, ApiException>(
      ApiException(),
    );
  }
}
