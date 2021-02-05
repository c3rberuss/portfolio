import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:services/src/models/application_model.dart';
import 'package:services/src/utils/serializers.dart';

part 'applications_response.g.dart';

abstract class ApplicationsResponse
    implements Built<ApplicationsResponse, ApplicationsResponseBuilder> {
  int get code;
  String get message;
  @nullable
  BuiltList<ApplicationModel> get data;

  ApplicationsResponse._();
  factory ApplicationsResponse([void Function(ApplicationsResponseBuilder) updates]) =
      _$ApplicationsResponse;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(ApplicationsResponse.serializer, this);
  }

  static ApplicationsResponse fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(ApplicationsResponse.serializer, json);
  }

  static Serializer<ApplicationsResponse> get serializer => _$applicationsResponseSerializer;
}
