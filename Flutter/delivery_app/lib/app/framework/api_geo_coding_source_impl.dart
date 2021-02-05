import 'package:app/app/models/geo_address_model.dart';
import 'package:app/app/utils/constants.dart';
import 'package:app/core/data/api_geo_coding_source.dart';
import 'package:app/core/domain/address_geo.dart';
import 'package:app/core/domain/resource.dart';
import 'network.dart';

class ApiGeoCodingSourceImpl extends ApiGeoCodingSource {
  Network _network;

  ApiGeoCodingSourceImpl(this._network);

  @override
  Future<Resource<AddressGeo>> getAddress(double latitude, double longitude) async {
    try {
      final response = await _network.instance.get(
        "/reverse",
        queryParameters: {
          "key": GEO_CODING_KEY,
          "location": "$latitude,$longitude",
          "thumbMaps": false,
        },
      );

      if (response.statusCode == 200) {
        final address = GeoAddressModel.fromJson(response.data['results'][0]['locations'][0]);
        return Success<GeoAddressModel>(address);
      }

      return Failure<GeoAddressModel, Exception>(
          Exception("It couldn't get the address [${response.statusCode}]"));
    } catch (error) {
      return Failure<GeoAddressModel, Exception>(Exception(error.toString()));
    }
  }
}
