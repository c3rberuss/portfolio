import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:wallpapers/src/models/image_model.dart';
import 'package:wallpapers/src/utils/serializers.dart';

part 'images_response.g.dart';

abstract class ImagesResponse implements Built<ImagesResponse, ImagesResponseBuilder> {
  int get statusCode;
  @nullable
  int get current;
  @nullable
  int get pages;
  BuiltList<ImageModel> get data;

  ImagesResponse._();
  factory ImagesResponse([void Function(ImagesResponseBuilder) updates]) = _$ImagesResponse;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(ImagesResponse.serializer, this);
  }

  static ImagesResponse fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(ImagesResponse.serializer, json);
  }

  static Serializer<ImagesResponse> get serializer => _$imagesResponseSerializer;
}