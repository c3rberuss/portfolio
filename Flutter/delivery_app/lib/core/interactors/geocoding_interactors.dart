import 'package:app/core/data/api_geo_coding_repository.dart';
import 'package:app/core/domain/address_geo.dart';
import 'package:app/core/domain/resource.dart';

class GetGeoAddressInt {
  final ApiGeoCodingRepository _repository;

  GetGeoAddressInt(this._repository);

  Future<Resource<AddressGeo>> call(double latitude, double longitude) =>
      _repository.getAddress(latitude, longitude);
}
