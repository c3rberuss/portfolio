import 'package:wallpapers/src/models/categories_response.dart';
import 'package:wallpapers/src/models/image_response.dart';
import 'package:wallpapers/src/models/images_response.dart';

abstract class DataRepository {
  Future<CategoriesResponse> fetchCategories({bool refresh = false});

  Future<ImagesResponse> fetchImages(int page, {bool refresh = false});

  Future<ImageResponse> fetchImage(String category, String name, {bool refresh = false});

  Future<ImagesResponse> fetchCategory(String categoryName, int page, {bool refresh = false});

  Future<ImagesResponse> searchImages(String query, int page, {bool refresh = false});

  Future<String> downloadImage(String urlFile, String fileName, Function(double) onProgress);
}
