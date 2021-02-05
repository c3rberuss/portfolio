import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:services/src/utils/serializers.dart';

part 'image_model.g.dart';

abstract class ImageModel implements Built<ImageModel, ImageModelBuilder> {
  String get path;

  ImageModel._();

  factory ImageModel([void Function(ImageModelBuilder) updates]) = _$ImageModel;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(ImageModel.serializer, this);
  }

  static ImageModel fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(ImageModel.serializer, json);
  }

  static Serializer<ImageModel> get serializer => _$imageModelSerializer;
}
