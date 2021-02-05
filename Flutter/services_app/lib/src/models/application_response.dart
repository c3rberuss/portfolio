import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:services/src/models/application_model.dart';
import 'package:services/src/utils/serializers.dart';

part 'application_response.g.dart';

abstract class ApplicationResponse
    implements Built<ApplicationResponse, ApplicationResponseBuilder> {
  int get code;
  String get message;
  @nullable
  ApplicationModel get data;

  ApplicationResponse._();
  factory ApplicationResponse([void Function(ApplicationResponseBuilder) updates]) =
      _$ApplicationResponse;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(ApplicationResponse.serializer, this);
  }

  static ApplicationResponse fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(ApplicationResponse.serializer, json);
  }

  static Serializer<ApplicationResponse> get serializer => _$applicationResponseSerializer;
}
