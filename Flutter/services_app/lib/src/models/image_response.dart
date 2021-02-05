import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:services/src/models/image_model.dart';
import 'package:services/src/utils/serializers.dart';

part 'image_response.g.dart';

abstract class ImageResponse implements Built<ImageResponse, ImageResponseBuilder> {
  int get code;

  String get message;

  ImageModel get data;

  ImageResponse._();

  factory ImageResponse([void Function(ImageResponseBuilder) updates]) = _$ImageResponse;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(ImageResponse.serializer, this);
  }

  static ImageResponse fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(ImageResponse.serializer, json);
  }

  static Serializer<ImageResponse> get serializer => _$imageResponseSerializer;
}
