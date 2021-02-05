import '../data/api_data_source.dart';
import '../domain/area.dart';
import '../domain/store.dart';
import '../domain/resource.dart';
import '../domain/service.dart';

class ApiRepository {
  final ApiDataSource _dataSource;

  ApiRepository(this._dataSource);

  Future<Resource<ServicesResponse>> fetchServices({int page = 0, bool refresh = false}) =>
      _dataSource.fetchServices(page: page, refresh: refresh);

  Future<Resource<List<Area>>> fetchServiceArea(int departmentId) =>
      _dataSource.fetchServiceArea(departmentId);

  Future<Resource<StoresResponse>> fetchStores(int serviceId,
          {int page = 0, bool refresh = false}) =>
      _dataSource.fetchStores(serviceId, page: page, refresh: refresh);
}
