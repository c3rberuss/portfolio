import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';
import 'package:services/src/models/application_model.dart';
import 'package:services/src/models/application_response.dart';
import 'package:services/src/models/categories_response.dart';
import 'package:services/src/models/image_response.dart';
import 'package:services/src/models/payment_intent_model.dart';
import 'package:services/src/models/payment_intent_response.dart';
import 'package:services/src/models/services_response.dart';
import 'package:services/src/repositories/applications_repository.dart';
import 'package:services/src/repositories/network_repository.dart';
import 'package:services/src/repositories/spreferences_repository_impl.dart';

class ApplicationsRepositoryImpl extends ApplicationsRepository {
  final SPreferencesRepositoryImpl preferences;
  final NetworkRepository network;

  ApplicationsRepositoryImpl(this.preferences, this.network);

  @override
  Future<CategoriesResponse> fetchCategories([bool refresh = true]) async {
    final response = await network.instance.get(
      "/catalogs",
      options: network.cacheOptions(forceRefresh: refresh),
    );

    return CategoriesResponse.fromJson(response.data);
  }

  @override
  Future<ServicesResponse> fetchServices(int categoryId, [bool refresh = true]) async {
    final response = await network.instance.get(
      "/catalogs/$categoryId/services",
      options: network.cacheOptions(forceRefresh: refresh),
    );

    return ServicesResponse.fromJson(response.data);
  }

  @override
  Future<ApplicationResponse> sendApplication(ApplicationModel application) async {
    final response = await network.instance.post(
      "/applications",
      data: application.toJson(),
      options: Options(contentType: "application/json"),
    );

    return Future.value(ApplicationResponse.fromJson(response.data));
  }

  @override
  Future<PaymentIntentResponse> createPaymentIntent(double amount, String paymentMethod,
      [bool half = true]) async {
    int _amount = 0;

    if (half) {
      _amount = int.parse(((double.parse(amount.toStringAsFixed(2)) / 2) * 100).toStringAsFixed(0));
    } else {
      _amount = int.parse((double.parse(amount.toStringAsFixed(2)) * 100).toStringAsFixed(0));
    }

    final intent = PaymentIntentModel((p) => p
      ..amount = _amount
      ..currency = "usd"
      ..paymentMethod = paymentMethod);

    final response = await network.stripe.post("/payment_intents",
        data: intent.toJson(), options: Options(contentType: "application/x-www-form-urlencoded"));

    return Future.value(PaymentIntentResponse.fromJson(response.data));
  }

  @override
  Future<ImageResponse> uploadImage(File image) async {
    final compressImage = await FlutterImageCompress.compressWithFile(image.path,
        minHeight: 1024, minWidth: 768, quality: 90, format: CompressFormat.jpeg);

    final data = FormData.fromMap({
      "asset": MultipartFile.fromBytes(
        compressImage,
        filename: basename(image.path).replaceAll(".jpg", ".jpeg"),
        contentType: MediaType('image', 'jpeg'),
      )
    });

    final response = await network.instance.post("/applications/uploadImage",
        data: data, options: Options(contentType: "multipart/form-data"));

    return ImageResponse.fromJson(response.data);
  }

  @override
  Future<ApplicationResponse> cancelApplication(int applicationId) async {
    final response = await network.instance.patch(
      "/Applications/cancel",
      data: {"application_id": applicationId},
    );

    return Future.value(ApplicationResponse.fromJson(response.data));
  }

  @override
  Future<ApplicationResponse> finishPayment(int applicationId, double amount) async {
    final response = await network.instance.patch(
      "/Applications/finishPayment",
      data: {"amount": amount, "application_id": applicationId},
    );

    return Future.value(ApplicationResponse.fromJson(response.data));
  }

  @override
  Future<ApplicationResponse> initialPayment(int applicationId, double amount) async {
    final response = await network.instance.patch(
      "/Applications/initialPayment",
      data: {"amount": amount, "application_id": applicationId},
    );

    return Future.value(ApplicationResponse.fromJson(response.data));
  }

  @override
  Future<ApplicationResponse> fetchApplication(int applicationId) async {
    final response = await network.instance.get(
      "/applications/api/$applicationId",
      options: network.cacheOptions(forceRefresh: true),
    );
    return Future.value(ApplicationResponse.fromJson(response.data));
  }
}
