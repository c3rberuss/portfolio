import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:wallpapers/src/models/categories_response.dart';
import 'package:wallpapers/src/models/category_model.dart';
import 'package:wallpapers/src/models/image_model.dart';
import 'package:wallpapers/src/models/image_response.dart';
import 'package:wallpapers/src/models/images_response.dart';

part 'serializers.g.dart';

@SerializersFor([
  ImageModel,
  CategoryModel,
  ImageResponse,
  ImagesResponse,
  CategoriesResponse,
])
final Serializers serializers = 
    (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();