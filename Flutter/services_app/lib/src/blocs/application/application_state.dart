import 'dart:io';

import 'package:built_collection/built_collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:services/src/models/application_model.dart';

class ApplicationState extends Equatable {
  final ApplicationModel application;
  final List<File> files;
  final bool allSelected;
  final bool serviceAdded;
  final bool serviceAlreadyExists;
  final bool servicesRemoved;
  final bool serviceSelected;
  final bool imageAdded;
  final bool imageRemoved;
  final bool sheetOpened;
  final double homeService;
  final bool calculatingCost;
  final bool sendingApplication;
  final bool updating;
  final String message;
  final double percent;
  final bool finishSuccess;
  final bool finishError;
  final bool onlyApplicationWithoutPayment;
  final bool existsService;

  int get count => application.services.length;

  int get countSelected => application.services.where((s) => s.selected).length;

  bool get emptyFiles => files.isEmpty;

  bool get noServicesAdded => application.services.isEmpty;

  double get totalNum => application.services.fold(0, (a, b) => a + b.price);

  double get workforceNum => application.services.fold(0, (a, b) => a + b.workforce);

  String get total => "\$" + totalNum.toStringAsFixed(2);

  String get workforce => "\$" + workforceNum.toStringAsFixed(2);

  //total for all
  String get totFinal => "\$" + (totalNum + workforceNum + homeService).toStringAsFixed(2);

  String get homeServiceStr => "\$" + homeService.toStringAsFixed(2);

  double get totalFinalNum =>
      double.parse((totalNum + workforceNum + homeService).toStringAsFixed(2));

  double get toPaid => (totalFinalNum / 2);

  ApplicationState({
    @required this.application,
    @required this.files,
    @required this.allSelected,
    @required this.serviceAdded,
    @required this.serviceAlreadyExists,
    @required this.servicesRemoved,
    @required this.serviceSelected,
    @required this.imageAdded,
    @required this.imageRemoved,
    @required this.sheetOpened,
    @required this.homeService,
    @required this.calculatingCost,
    @required this.sendingApplication,
    @required this.updating,
    @required this.message,
    @required this.percent,
    @required this.finishError,
    @required this.finishSuccess,
    @required this.onlyApplicationWithoutPayment,
    @required this.existsService,
  });

  factory ApplicationState.initial() {
    final app = ApplicationModel((a) => a
      ..applicationId = -1
      ..images = ListBuilder()
      ..services = ListBuilder()
      ..description = ""
      ..latitude = 0.0
      ..longitude = 0.0
      ..moneyPaid = 0.0
      ..createdAt = ""
      ..total = 0.0);

    return ApplicationState(
      application: app,
      files: [],
      allSelected: false,
      serviceAdded: false,
      serviceAlreadyExists: false,
      servicesRemoved: false,
      serviceSelected: false,
      imageAdded: false,
      imageRemoved: false,
      sheetOpened: false,
      homeService: 0.0,
      calculatingCost: false,
      sendingApplication: false,
      percent: 0.0,
      message: "Uploading images...",
      updating: false,
      finishSuccess: false,
      finishError: false,
      onlyApplicationWithoutPayment: false,
      existsService: false,
    );
  }

  ApplicationState copyWith({
    ApplicationModel application,
    List<File> files,
    bool allSelected,
    bool serviceAdded,
    bool serviceAlreadyExists,
    bool servicesRemoved,
    bool serviceSelected,
    bool imageAdded,
    bool imageRemoved,
    bool sheetOpened,
    PersistentBottomSheetController controller,
    double homeService,
    bool calculating,
    bool sending,
    bool updating,
    double percent,
    String message,
    bool success,
    bool error,
    bool withoutPayment,
    bool serviceExists,
  }) {
    return ApplicationState(
      application: application ?? this.application,
      files: files ?? this.files,
      allSelected: allSelected ?? this.allSelected,
      serviceAdded: serviceAdded ?? this.serviceAdded,
      serviceAlreadyExists: serviceAlreadyExists ?? this.serviceAlreadyExists,
      servicesRemoved: servicesRemoved ?? this.servicesRemoved,
      serviceSelected: serviceSelected ?? this.serviceSelected,
      imageAdded: imageAdded ?? this.imageAdded,
      imageRemoved: imageRemoved ?? this.imageRemoved,
      sheetOpened: sheetOpened ?? this.sheetOpened,
      homeService: homeService ?? this.homeService,
      calculatingCost: calculating ?? this.calculatingCost,
      sendingApplication: sending ?? this.sendingApplication,
      updating: updating ?? this.updating,
      message: message ?? this.message,
      percent: percent ?? this.percent,
      finishSuccess: success ?? this.finishSuccess,
      finishError: error ?? this.finishError,
      onlyApplicationWithoutPayment: withoutPayment ?? this.onlyApplicationWithoutPayment,
      existsService: serviceExists ?? this.existsService,
    );
  }

  @override
  List<Object> get props => [
        application,
        files,
        allSelected,
        serviceSelected,
        servicesRemoved,
        serviceAlreadyExists,
        imageAdded,
        imageRemoved,
        sheetOpened,
        homeService,
        calculatingCost,
        sendingApplication,
        updating,
        message,
        percent,
        finishSuccess,
        finishError,
        onlyApplicationWithoutPayment,
        existsService,
      ];
}
