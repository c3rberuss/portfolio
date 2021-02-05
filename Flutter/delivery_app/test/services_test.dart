import 'package:app/app/models/pagination_model.dart';
import 'package:app/app/models/service_model.dart';
import 'package:app/app/modules/home/controllers/services_controller.dart';
import 'package:app/core/data/api_data_source.dart';
import 'package:app/core/data/api_repository.dart';
import 'package:app/core/domain/resource.dart';
import 'package:app/core/domain/service.dart';
import 'package:app/core/interactors/api_interactors.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class ApiDataSourceMock extends Mock implements ApiDataSource {}

Future<Resource<ServicesResponse>> _fakeData([int page = 0]) async {
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

main() {
  final _dataSource = ApiDataSourceMock();
  final _repository = ApiRepository(_dataSource);

  group("Services controller test", () {
    final _controller = ServicesController(
      FetchServicesInt(_repository),
    );

    test("Fetch Services Success", () async {
      when(_dataSource.fetchServices(page: anyNamed("page"))).thenAnswer((_) async {
        return await _fakeData(_controller.currentPage);
      });

      await _controller.fetchData();
      expect(_controller.status, isA<Success>());

      //Initial fetch => current page is 0
      expect(_controller.data.length, 10);
      expect(_controller.currentPage, 0);

      //Loading more => current page is 1
      await _controller.fetchData(loadMore: true);
      expect(_controller.data.length, 20);
      expect(_controller.currentPage, 1);

      //Now the current page is 2
      await _controller.fetchData(loadMore: true);
      expect(_controller.currentPage, 2);

      //Total page should be 5
      expect(_controller.totalPages, 5);

      //Now the current page is 3
      await _controller.fetchData(loadMore: true);

      //Now the current page is 4
      await _controller.fetchData(loadMore: true);
      expect(_controller.currentPage, 4);

      //Now the current page will be the same (4) because there isn't more data to load
      await _controller.fetchData(loadMore: true);
      expect(_controller.currentPage, 4);
    });

    test("Fetch Services - Refresh", () async {
      reset(_dataSource);

      when(_dataSource.fetchServices(page: anyNamed("page"), refresh: anyNamed("refresh")))
          .thenAnswer((_) async {
        return await _fakeData();
      });

      //Refresh services
      await _controller.fetchData(refresh: true);
      expect(_controller.data.length, 10);
      expect(_controller.currentPage, 0);
      expect(_controller.totalPages, 5);
    });

    test("Fetch Services Failed", () async {
      reset(_dataSource);

      when(_dataSource.fetchServices(page: anyNamed("page"), refresh: anyNamed("refresh")))
          .thenAnswer(
        (_) => Future.value(
          Failure<ServicesResponse, DioError>(),
        ),
      );

      await _controller.fetchData(refresh: true);
      expect(_controller.status, isA<Failure>());
    });
  });
}
