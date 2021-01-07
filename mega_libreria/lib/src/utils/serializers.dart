import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:megalibreria/src/models/addresses/address_model.dart';
import 'package:megalibreria/src/models/addresses/address_status.dart';
import 'package:megalibreria/src/models/addresses/address_type.dart';
import 'package:megalibreria/src/models/categories/categories_pagination.dart';
import 'package:megalibreria/src/models/categories/categories_response.dart';
import 'package:megalibreria/src/models/categories/category_model.dart';
import 'package:megalibreria/src/models/locations/city_model.dart';
import 'package:megalibreria/src/models/locations/department_model.dart';
import 'package:megalibreria/src/models/orders/fare_model.dart';
import 'package:megalibreria/src/models/orders/fare_response.dart';
import 'package:megalibreria/src/models/orders/order_detail_model.dart';
import 'package:megalibreria/src/models/orders/order_model.dart';
import 'package:megalibreria/src/models/orders/orders_response.dart';
import 'package:megalibreria/src/models/orders/payment_type.dart';
import 'package:megalibreria/src/models/products/product_model.dart';
import 'package:megalibreria/src/models/products/product_type.dart';
import 'package:megalibreria/src/models/products/products_pagination.dart';
import 'package:megalibreria/src/models/products/products_response.dart';
import 'package:megalibreria/src/models/response.dart';
import 'package:megalibreria/src/models/users/user_model.dart';
import 'package:megalibreria/src/models/users/user_response.dart';

part 'serializers.g.dart';

@SerializersFor([
  UserModel,
  UserResponse,
  DepartmentModel,
  CityModel,
  CategoryModel,
  CategoriesPagination,
  CategoriesResponse,
  ProductModel,
  ProductsPagination,
  ProductsResponse,
  ProductType,
  FareModel,
  FareResponse,
  OrderModel,
  OrdersResponse,
  OrdersResponse,
  AddressModel,
  AddressStatus,
  AddressType,
  OrderDetailModel,
  PaymentType,
  Response,
])
final Serializers serializers =
    (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
