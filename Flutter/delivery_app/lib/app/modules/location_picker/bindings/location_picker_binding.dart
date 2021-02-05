import 'package:app/app/framework/api_geo_coding_source_impl.dart';
import 'package:app/app/framework/network.dart';
import 'package:app/app/utils/constants.dart';
import 'package:app/core/data/api_geo_coding_repository.dart';
import 'package:app/core/interactors/api_interactors.dart';
import 'package:app/core/interactors/geocoding_interactors.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:get/get.dart';

import 'package:app/app/modules/location_picker/controllers/location_picker_controller.dart';

class LocationPickerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GetGeoAddressInt>(
      () => GetGeoAddressInt(
        ApiGeoCodingRepository(
          ApiGeoCodingSourceImpl(
            Network(
              baseUrl: GEO_CODING_URL,
              token: false,
              cache: true,
              cacheManager: DioCacheManager(
                CacheConfig(
                  baseUrl: GEO_CODING_URL,
                  defaultMaxAge: Duration(days: 7),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    Get.lazyPut<FetchServiceAreaInt>(
      () => FetchServiceAreaInt(Get.find()),
    );

    Get.lazyPut<LocationPickerController>(
      () => LocationPickerController(
        getGeoAddressInt: Get.find(),
        fetchServiceAreaInt: Get.find(),
      ),
    );
  }
}
