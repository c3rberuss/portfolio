

import 'package:megalibreria/src/models/categories/categories_response.dart';
import 'package:megalibreria/src/models/locations/cities_response.dart';
import 'package:megalibreria/src/models/locations/departments_response.dart';
import 'package:megalibreria/src/models/products/products_response.dart';

import 'data_repository.dart';
import 'network_repository.dart';

class DataRepositoryImpl extends DataRepository {
  final NetworkRepository _network;

  DataRepositoryImpl(this._network);

  @override
  Future<CategoriesResponse> fetchCategories([int page = 1, bool refresh = false]) async {
    final response = await _network.instance.get(
      "/categorias/api/$page",
      options: _network.cacheOptions(forceRefresh: refresh),
    );
    return CategoriesResponse.fromJson(response.data);
  }

  @override
  Future<ProductsResponse> fetchProducts(int categoryId,
      [int page = 1, bool refresh = false]) async {

    print("URL: /productos/api/mostrar/$categoryId/$page");

    final response = await _network.instance.get(
      "/productos/api/mostrar/$categoryId/$page",
      options: _network.cacheOptions(forceRefresh: refresh),
    );

    return ProductsResponse.fromJson(response.data);
  }

  @override
  Future<CitiesResponse> fetchCities(int departmentId, [bool refresh = false]) async {
    final response = await _network.instance.get(
      "/clientes/api/municipio/$departmentId",
      options: _network.cacheOptions(forceRefresh: refresh),
    );
    return CitiesResponse.fromJson(response.data);
  }

  @override
  Future<DepartmentsResponse> fetchDepartments([bool refresh = false]) async {
    final response = await _network.instance.get(
      "/clientes/api/departamento",
      options: _network.cacheOptions(forceRefresh: refresh),
    );
    return DepartmentsResponse.fromJson(response.data);
  }

  @override
  Future<ProductsResponse> searchProducts(String query, [int page = 1, bool refresh = true]) async {

    print("URL: /productos/api/search/$query/$page");

    final response = await _network.instance.get(
      "/productos/api/search/$query/$page",
      options: _network.cacheOptions(forceRefresh: refresh),
    );
    return ProductsResponse.fromJson(response.data);
  }
}
