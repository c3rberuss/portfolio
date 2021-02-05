import 'package:bookshop/src/models/locations/department_model.dart';
import 'package:bookshop/src/utils/serializers.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'departments_response.g.dart';

abstract class DepartmentsResponse
    implements Built<DepartmentsResponse, DepartmentsResponseBuilder> {
  int get code;
  String get message;
  @nullable
  BuiltList<DepartmentModel> get data;

  DepartmentsResponse._();
  factory DepartmentsResponse([void Function(DepartmentsResponseBuilder) updates]) =
      _$DepartmentsResponse;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(DepartmentsResponse.serializer, this);
  }

  static DepartmentsResponse fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(DepartmentsResponse.serializer, json);
  }

  static Serializer<DepartmentsResponse> get serializer => _$departmentsResponseSerializer;
}
