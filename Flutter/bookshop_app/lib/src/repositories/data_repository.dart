import 'dart:async';

import 'package:bookshop/src/models/categories/categories_response.dart';
import 'package:bookshop/src/models/locations/cities_response.dart';
import 'package:bookshop/src/models/locations/departments_response.dart';
import 'package:bookshop/src/models/products/products_response.dart';

abstract class DataRepository {
  Future<CategoriesResponse> fetchCategories([int page = 1, bool refresh = false]);
  Future<ProductsResponse> fetchProducts(int categoryId, [int page = 1, bool refresh = false]);
  Future<DepartmentsResponse> fetchDepartments([bool refresh = false]);
  Future<CitiesResponse> fetchCities(int departmentId, [bool refresh = false]);
  Future<ProductsResponse> searchProducts(String query, [int page = 1, bool refresh = true]);
}
