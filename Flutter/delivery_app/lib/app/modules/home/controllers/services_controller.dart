import 'package:app/app/framework/pagination_controller.dart';
import 'package:app/core/domain/resource.dart';
import 'package:app/core/domain/service.dart';
import 'package:app/core/interactors/api_interactors.dart';

class ServicesController extends PaginationController<Service, ServicesResponse> {
  final FetchServicesInt _fetchServices;

  ServicesController(this._fetchServices);

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  @override
  Future<Resource<ServicesResponse>> fetch(int page, bool refresh) async {
    return await _fetchServices(page: page, refresh: refresh);
  }
}
