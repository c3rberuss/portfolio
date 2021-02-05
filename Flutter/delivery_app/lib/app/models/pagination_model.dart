import 'package:app/core/domain/response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pagination_model.g.dart';

@JsonSerializable(nullable: true, createToJson: false)
class PaginationModel extends Pagination {
  PaginationModel({int totalElements, int totalPages, int page, int numberOfElements})
      : super(
          totalElements: totalElements,
          totalPages: totalPages,
          page: page,
          numberOfElements: numberOfElements,
        );

  factory PaginationModel.fromJson(Map<String, dynamic> json) => _$PaginationModelFromJson(json);
}
