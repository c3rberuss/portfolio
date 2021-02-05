import 'package:app/core/domain/area.dart';

import '../domain/resource.dart';
import '../domain/service.dart';
import '../domain/store.dart';

abstract class ApiDataSource {
  Future<Resource<ServicesResponse>> fetchServices({int page = 0, bool refresh = false});
  Future<Resource<StoresResponse>> fetchStores(int serviceId, {int page = 0, bool refresh = false});
  Future<Resource<List<Area>>> fetchServiceArea(int departmentId);
}
