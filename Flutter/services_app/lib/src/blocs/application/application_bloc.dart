import 'dart:async';
import 'dart:math' as math;

import 'package:bloc/bloc.dart';
import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:location/location.dart';
import 'package:stripe_sdk/stripe_sdk.dart';
import 'package:stripe_sdk/stripe_sdk_ui.dart';
import 'package:services/src/blocs/application/application_state.dart';
import 'package:services/src/models/application_model.dart';
import 'package:services/src/models/card_model.dart';
import 'package:services/src/models/image_model.dart';
import 'package:services/src/repositories/applications_repository_impl.dart';
import 'package:services/src/repositories/spreferences_repository_impl.dart';

import './bloc.dart';

class ApplicationBloc extends Bloc<ApplicationEvent, ApplicationState> {
  SPreferencesRepositoryImpl preferences;
  ApplicationsRepositoryImpl repository;

  ApplicationBloc(this.preferences, this.repository);

  @override
  ApplicationState get initialState => ApplicationState.initial();

  @override
  Stream<ApplicationState> mapEventToState(
    ApplicationEvent event,
  ) async* {
    if (event is AddServiceEvent) {
      //When a service is added to List

      if (state.application.services.contains(event.service)) {
        yield state.copyWith(serviceExists: true, serviceAdded: false);
      } else {
        final application = state.application.rebuild((a) => a..services.add(event.service));
        yield state.copyWith(application: application, serviceAdded: true, serviceExists: false);
      }

      yield state.copyWith(serviceAdded: false, serviceExists: false);
    } else if (event is SelectAllEvent) {
      //When all services are selected
      final services = state.application.services.toList();

      for (int i = 0; i < services.length; i++) {
        services[i] = services[i].rebuild((s) => s..selected = event.value);
      }

      final application = state.application.rebuild(
        (a) => a
          ..services.update(
            (s) => s
              ..clear()
              ..addAll(services),
          ),
      );

      yield state.copyWith(application: application, allSelected: event.value);
    } else if (event is RemoveServicesEvent) {
      //Remove all services selected
      yield state.copyWith(
          application: state.application
              .rebuild((a) => a..services.update((s) => s..removeWhere((sd) => sd.selected))),
          allSelected: false,
          servicesRemoved: true);

      yield state.copyWith(servicesRemoved: false);
    } else if (event is SelectServiceEvent) {
      //When an service is selected or unselected
      yield state.copyWith(
        application: state.application.rebuild((a) => a
          ..services.update(
              (s) => s..[event.index] = s[event.index].rebuild((v) => v..selected = event.value))),
        serviceSelected: true,
        allSelected: false,
      );

      yield state.copyWith(serviceSelected: false);
    } else if (event is UnselectedAllEvent) {
      //When all services are unselected
      final services = state.application.services.toList();

      for (int i = 0; i < services.length; i++) {
        services[i] = services[i].rebuild((s) => s..selected = false);
      }

      final application = state.application.rebuild(
        (a) => a
          ..services.update(
            (s) => s
              ..clear()
              ..addAll(services),
          ),
      );

      yield state.copyWith(application: application, allSelected: false, serviceSelected: false);
    } else if (event is AddImageEvent) {
      //When an image is added

      state.files.add(event.image);

      yield state.copyWith(imageAdded: true);
      yield state.copyWith(imageAdded: false);
    } else if (event is RemoveImageEvent) {
      //When image is deleted
      state.files.removeAt(event.index);
      yield state.copyWith(imageRemoved: true);
      yield state.copyWith(imageRemoved: false);
    } else if (event is ShowOrHideBottomSheet) {
      //when bottom sheet is opened
      if (event.forceClose) {
        yield state.copyWith(sheetOpened: false);
      } else {
        yield state.copyWith(sheetOpened: !state.sheetOpened);
      }
    } else if (event is ObtainLocation) {
      yield state.copyWith(calculating: true);
      yield* _mapGetHomeService();
    } else if (event is ClearApplicationEvent) {
      yield ApplicationState.initial();
    } else if (event is ChangeDescriptionEvent) {
      yield state.copyWith(
        application: state.application.rebuild(
          (a) => a..description = event.description,
        ),
      );
    } else if (event is SendApplicationEvent) {
      yield* _mapSendApplication(event.card);
    }
  }

  double _percent(int number, int total) {
    return double.parse(((number / total) * 100.0).toStringAsFixed(2));
  }

  double _deg2rad(degrees) {
    return degrees * (math.pi / 180.0);
  }

  double _rad2deg(radians) {
    return radians * (180.0 / math.pi);
  }

  Stream<ApplicationState> _mapSendApplication(CardModel card) async* {
    final total = state.files.length + 2;
    bool errorUploadImages = false;
    bool errorSendApplication = false;
    final files = state.files;
    List<ImageModel> images = List();
    ApplicationModel app;

    yield state.copyWith(sending: true);

    try {
      for (int i = 0; i < files.length; i++) {
        int index = i;

        yield state.copyWith(
          message: "Upload image ${index + 1}/${files.length}",
          sending: false,
          percent: _percent(index + 1, total),
          updating: true,
        );

        final image = await repository.uploadImage(files[i]);

        images.add(image.data);
      }

      yield state.copyWith(
        message: "All images has been uploaded.",
      );
    } on DioError catch (error) {
      if (error.response != null) {
        yield state.copyWith(
            updating: false, sending: false, error: true, message: "Cant upload images.");

        errorUploadImages = true;
      }
    }

    if (!errorUploadImages) {
      final application = state.application.rebuild(
        (a) => a
          ..total = (state.totalNum + state.workforceNum + state.homeService)
          ..images = ListBuilder(images),
      );

      try {
        yield state.copyWith(
          message: "Send Application...",
          sending: false,
          percent: _percent(total - 1, total),
          updating: true,
          application: application,
        );

        final response = await repository.sendApplication(application);

        app = response.data;

        print("RES APP: $app");
      } on DioError catch (error) {
        if (error.response != null) {
          yield state.copyWith(
              updating: false, sending: false, error: true, message: "Cant send application");

          errorSendApplication = true;
        }
      }
    }

    if (!errorUploadImages && !errorSendApplication) {
      final stripeCard = StripeCard(
        number: card.number,
        name: card.name,
        cvc: card.cvc,
        expMonth: card.expMonth,
        expYear: card.expYear,
      );

      yield state.copyWith(
        message: "Creating Payment",
        percent: _percent(total, total),
        updating: true,
      );

      try {
        final paymentMethod = await StripeApi.instance.createPaymentMethodFromCard(stripeCard);

        try {
          final paymentIntent = await repository.createPaymentIntent(
            state.application.total,
            paymentMethod['id'],
          );

          yield state.copyWith(
            message: "Payment verification",
            percent: _percent(total, total),
            updating: true,
          );

          await StripeApi.instance.confirmPaymentIntent(paymentIntent.clientSecret);

          final amount = (double.parse(app.total.toStringAsFixed(2)) / 2);
          await repository.initialPayment(app.applicationId, amount);

          yield state.copyWith(
            updating: false,
            success: true,
            withoutPayment: false,
            message: "Success! Application sended!.",
          );
        } on DioError catch (error) {
          if (error.response != null) {
            await repository.cancelApplication(app.applicationId);
            yield state.copyWith(
                updating: false, error: true, message: "Payment Failed, try again");
          }
        }
      } on StripeApiException catch (stripeError) {
        print("ERROR TYPE: ${stripeError.error.type} || ${stripeError.error.message}");
        await repository.cancelApplication(app.applicationId);
        yield state.copyWith(updating: false, error: true, message: stripeError.message);
      }

      yield state.copyWith(updating: false, error: false, success: false);
    }
  }

  Stream<ApplicationState> _mapGetHomeService() async* {
    double total = 0.0;
    final originLat = await preferences.getDouble("lat");
    final originLng = await preferences.getDouble("lon");
    final cost = await preferences.getDouble("cost");

    final coordinates = await Location().getLocation();
    final lon = coordinates.longitude;
    final lat = coordinates.latitude;

    final theta = lon - originLng;

    double dist = math.sin(_deg2rad(lat)) * math.sin(_deg2rad(originLat)) +
        math.cos(_deg2rad(lat)) * math.cos(_deg2rad(originLat)) * math.cos(_deg2rad(theta));
    dist = math.acos(dist);
    dist = _rad2deg(dist);
    final miles = dist * 60 * 1.1515;

    total = (miles * 1.609344) * cost;

    yield state.copyWith(
      homeService: total,
      calculating: false,
      application: state.application.rebuild((a) => a
        ..latitude = lat
        ..longitude = lon),
    );
  }
}
