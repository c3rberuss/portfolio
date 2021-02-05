import 'package:path_provider/path_provider.dart';
import 'package:wallpapers/src/models/categories_response.dart';
import 'package:wallpapers/src/models/image_response.dart';
import 'package:wallpapers/src/models/images_response.dart';
import 'package:wallpapers/src/repositories/data_repository.dart';
import 'package:wallpapers/src/repositories/network_repository.dart';

class DataRepositoryImpl extends DataRepository {
  NetworkRepository _network;

  DataRepositoryImpl(this._network);

  @override
  Future<CategoriesResponse> fetchCategories({bool refresh = false}) async {
    final response = await _network.instance.get("/categories");
    return CategoriesResponse.fromJson(response.data);
  }

  @override
  Future<ImagesResponse> fetchCategory(String categoryName, int page,
      {bool refresh = false}) async {
    final response = await _network.instance.get("/categories/$categoryName/$page");
    return ImagesResponse.fromJson(response.data);
  }

  @override
  Future<ImageResponse> fetchImage(String category, String name, {bool refresh = false}) async {
    final response = await _network.instance.get(
      "/images/$category/$name",
      options: _network.cacheOptions(),
    );
    return ImageResponse.fromJson(response.data);
  }

  @override
  Future<ImagesResponse> fetchImages(int page, {bool refresh = false}) async {
    final response = await _network.instance.get("/images/$page");
    return ImagesResponse.fromJson(response.data);
  }

  @override
  Future<ImagesResponse> searchImages(String query, int page, {bool refresh = false}) async {
    final response = await _network.instance.get("/images/search/$query/$page");
    return ImagesResponse.fromJson(response.data);
  }

  @override
  Future<String> downloadImage(String urlFile, String fileName, Function(double) onProgress) async {
    final savePath = await getApplicationDocumentsDirectory();

    final response = await _network.instance.download(
      urlFile,
      savePath.path + "/$fileName.jpg",
      deleteOnError: true,
      onReceiveProgress: (int received, int total) {
        final progress = (received / total * 100);
        onProgress(progress);
      },
    );

    return savePath.path + "/$fileName.jpg";
  }
}
