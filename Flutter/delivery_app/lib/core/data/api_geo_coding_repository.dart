import 'package:app/core/domain/address_geo.dart';
import 'package:app/core/domain/resource.dart';

import 'api_geo_coding_source.dart';

class ApiGeoCodingRepository {
  final ApiGeoCodingSource _geoCodingSource;

  ApiGeoCodingRepository(this._geoCodingSource);

  Future<Resource<AddressGeo>> getAddress(double latitude, double longitude) =>
      _geoCodingSource.getAddress(latitude, longitude);
}
