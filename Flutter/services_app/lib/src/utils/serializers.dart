import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:services/src/models/application_detail.dart';
import 'package:services/src/models/application_model.dart';
import 'package:services/src/models/application_response.dart';
import 'package:services/src/models/application_status_model.dart';
import 'package:services/src/models/applications_response.dart';
import 'package:services/src/models/categories_response.dart';
import 'package:services/src/models/category_model.dart';
import 'package:services/src/models/image_model.dart';
import 'package:services/src/models/image_response.dart';
import 'package:services/src/models/notification_data_model.dart';
import 'package:services/src/models/notification_model.dart';
import 'package:services/src/models/notification_origin.dart';
import 'package:services/src/models/notification_response.dart';
import 'package:services/src/models/notification_type.dart';
import 'package:services/src/models/payment_intent_model.dart';
import 'package:services/src/models/payment_intent_response.dart';
import 'package:services/src/models/service_model.dart';
import 'package:services/src/models/services_response.dart';
import 'package:services/src/models/user_model.dart';
import 'package:services/src/models/user_response.dart';

part 'serializers.g.dart';

@SerializersFor([
  UserModel,
  CategoryModel,
  ServiceModel,
  CategoriesResponse,
  ServicesResponse,
  UserResponse,
  ApplicationModel,
  ApplicationDetail,
  ImageModel,
  ImageResponse,
  ApplicationStatusModel,
  PaymentIntentModel,
  PaymentIntentResponse,
  ApplicationResponse,
  ApplicationsResponse,
  NotificationType,
  NotificationDataModel,
  NotificationModel,
  NotificationResponse,
  NotificationOrigin,
])
final Serializers serializers =
    (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
