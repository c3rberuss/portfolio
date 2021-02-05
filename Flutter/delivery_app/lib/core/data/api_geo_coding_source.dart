import 'package:app/core/domain/address_geo.dart';
import 'package:app/core/domain/resource.dart';

abstract class ApiGeoCodingSource {
  Future<Resource<AddressGeo>> getAddress(double latitude, double longitude);
}
