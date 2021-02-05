import 'dart:io';

import 'package:services/src/models/application_model.dart';
import 'package:services/src/models/application_response.dart';
import 'package:services/src/models/categories_response.dart';
import 'package:services/src/models/image_response.dart';
import 'package:services/src/models/payment_intent_response.dart';
import 'package:services/src/models/services_response.dart';

abstract class ApplicationsRepository {
  Future<CategoriesResponse> fetchCategories([bool refresh = true]);

  Future<ServicesResponse> fetchServices(int categoryId, [bool refresh = true]);

  Future<ApplicationResponse> sendApplication(ApplicationModel application);

  Future<PaymentIntentResponse> createPaymentIntent(double amount, String paymentMethod,
      [bool half = true]);
  Future<ImageResponse> uploadImage(File image);
  Future<ApplicationResponse> initialPayment(int applicationId, double amount);
  Future<ApplicationResponse> finishPayment(int applicationId, double amount);
  Future<ApplicationResponse> cancelApplication(int applicationId);
  Future<ApplicationResponse> fetchApplication(int applicationId);
}
