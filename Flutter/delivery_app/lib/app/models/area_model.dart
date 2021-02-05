import 'package:app/core/domain/area.dart';
import 'package:json_annotation/json_annotation.dart';

part 'area_model.g.dart';

@JsonSerializable(createToJson: false)
@_CoordinateConverter()
class AreasResponseModel extends AreasResponse {
  AreasResponseModel({
    int status,
    String timestamp,
    String message,
    List<AreaModel> data,
  }) : super(
          status: status,
          timestamp: timestamp,
          message: message,
          data: data,
        );

  factory AreasResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AreasResponseModelFromJson(json);
}

@JsonSerializable(createToJson: false)
class AreaModel extends Area {
  AreaModel(int id, String name, List<CoordinateModel> coordinates) : super(id, name, coordinates);

  factory AreaModel.fromJson(Map<String, dynamic> json) => _$AreaModelFromJson(json);
}

@JsonSerializable()
class CoordinateModel extends Coordinate {
  CoordinateModel(double latitude, double longitude) : super(latitude, longitude);

  factory CoordinateModel.fromJson(Map<String, dynamic> json) => _$CoordinateModelFromJson(json);
  Map<String, dynamic> toJson() => _$CoordinateModelToJson(this);
}

class _CoordinateConverter implements JsonConverter<Coordinate, Map<String, double>> {
  const _CoordinateConverter();

  @override
  Coordinate fromJson(Map<String, double> json) {
    return Coordinate(json['latitude'], json['longitude']);
  }

  @override
  Map<String, double> toJson(Coordinate object) {
    return {
      "latitude": object.latitude,
      "longitude": object.longitude,
    };
  }
}
