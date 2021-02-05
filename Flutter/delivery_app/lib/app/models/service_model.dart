import 'package:app/app/models/pagination_model.dart';
import 'package:app/core/domain/service.dart';
import 'package:json_annotation/json_annotation.dart';

part 'service_model.g.dart';

@JsonSerializable(nullable: true, createToJson: false)
class ServicesResponseModel extends ServicesResponse {
  ServicesResponseModel({
    int status,
    String timestamp,
    String message,
    List<ServiceModel> data,
    PaginationModel pagination,
  }) : super(
          status: status,
          timestamp: timestamp,
          message: message,
          data: data,
          pagination: pagination,
        );

  factory ServicesResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ServicesResponseModelFromJson(json);
}

@JsonSerializable(createToJson: false)
class ServiceModel extends Service {
  factory ServiceModel.fromJson(Map<String, dynamic> json) => _$ServiceModelFromJson(json);

  @JsonKey(name: "iconURL")
  String image;

  ServiceModel({int id, String name, String description, this.image})
      : super(id: id, name: name, description: description, image: image);
}
