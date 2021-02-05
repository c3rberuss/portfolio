import 'package:app/app/models/pagination_model.dart';
import 'package:app/app/models/service_model.dart';
import 'package:app/core/data/api_data_source.dart';
import 'package:app/core/domain/resource.dart';
import 'package:app/core/domain/service.dart';
import 'package:app/core/domain/store.dart';
import 'package:app/core/domain/area.dart';

class ApiDataSourceTestImpl implements ApiDataSource {
  @override
  Future<Resource<ServicesResponse>> fetchServices({int page = 0, bool refresh = false}) async {
    final List<ServiceModel> services = List.generate(
      10,
      (index) => ServiceModel(
        id: 1,
        name: "Service ${index + 1}",
        description: "",
        image: "https://api.customer.llegosv.com/static/no_image_available.svg",
      ),
    );

    await Future.delayed(Duration(seconds: 2));

    return Success<ServicesResponse>(
      ServicesResponse(
        status: 200,
        timestamp: "",
        message: "Ok",
        data: services,
        pagination: PaginationModel(
          totalElements: 50,
          page: page,
          totalPages: 5,
          numberOfElements: 10,
        ),
      ),
    );
  }

  @override
  Future<Resource<StoresResponse>> fetchStores(int serviceId,
      {int page = 0, bool refresh = false}) async {
    return Future.value();
  }

  @override
  Future<Resource<List<Area>>> fetchServiceArea(int departmentId) {
    // TODO: implement fetchZones
    throw UnimplementedError();
  }
}
