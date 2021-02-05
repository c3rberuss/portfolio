import '../domain/store.dart';
import '../data/api_repository.dart';
import '../domain/resource.dart';
import '../domain/service.dart';
import '../domain/area.dart';

class _ApiInteractor {
  final ApiRepository _repository;

  _ApiInteractor(this._repository);
}

class FetchServicesInt extends _ApiInteractor {
  FetchServicesInt(ApiRepository repository) : super(repository);

  Future<Resource<ServicesResponse>> call({int page = 0, bool refresh = false}) =>
      this._repository.fetchServices(page: page, refresh: refresh);
}

class FetchServiceAreaInt extends _ApiInteractor {
  FetchServiceAreaInt(ApiRepository repository) : super(repository);

  Future<Resource<List<Area>>> call(int departmentId) => _repository.fetchServiceArea(departmentId);
}

class FetchStoresInt extends _ApiInteractor {
  FetchStoresInt(ApiRepository repository) : super(repository);

  Future<Resource<StoresResponse>> call(int serviceId, {int page = 0, bool refresh = false}) =>
      _repository.fetchStores(serviceId, page: page, refresh: refresh);
}
